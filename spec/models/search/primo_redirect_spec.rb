require 'spec_helper'

describe Search::PrimoRedirect do
  subject { described_class.new({q: "example", institution: 'NDU', tab: 'onesearch'})}

  describe '#accept_params' do
    it "accepts primo params" do
      expect(subject.accept_params).to be == [:q, :institution, :vid, :tab, :search_scope]
    end
  end

  describe '#query_params' do
    it "changes q to query and adds stats_search_type" do
      expect(subject.query_params).to be == {
        query: 'any,contains,example',
        institution: 'NDU',
        vid: 'NDU',
        tab: 'onesearch',
        search_scope: 'malc_blended',
        indx: 1,
        bulkSize: 10,
        highlight: 'true',
        dym: 'true',
        onCampus: 'false'
      }
    end
  end

  describe '#default_search_scope' do
    it "returns the default for NDU and onesearch" do
      subject.stub(:institution).and_return('NDU')
      subject.stub(:tab).and_return('onesearch')
      expect(subject.default_search_scope).to be == 'malc_blended'
    end

    it "returns the default for SMC and smc" do
      subject.stub(:institution).and_return('SMC')
      subject.stub(:tab).and_return('smc')
      expect(subject.default_search_scope).to be == 'SMC'
    end

    it "returns nil if the tab isn't found" do
      subject.stub(:tab).and_return('faketab')
      expect(subject.default_search_scope).to be_nil
    end

    it "returns nil if the institution isn't found" do
      subject.stub(:institution).and_return('fakeinstitution')
      expect(subject.default_search_scope).to be_nil
    end
  end

  describe '#search_scope' do
    it "returns params[:search_scope] if present" do
      subject.stub(:params).and_return({search_scope: 'myscope'})
      expect(subject.search_scope).to be == 'myscope'
    end

    it "returns #default_search_scope if not present" do
      subject.stub(:default_search_scope).and_return('defaultscope')
      subject.stub(:params).and_return({})
      expect(subject.search_scope).to be == 'defaultscope'
    end
  end

  describe '#vid' do
    it "returns params[:vid] if present" do
      subject.stub(:params).and_return({vid: 'myvid'})
      expect(subject.vid).to be == 'myvid'
    end

    it "returns #institution if not present" do
      subject.stub(:institution).and_return('institution')
      subject.stub(:params).and_return({})
      expect(subject.vid).to be == 'institution'
    end
  end

  describe '#path' do
    it "is the deep link search page" do
      expect(subject.path).to be == '/primo_library/libweb/action/dlSearch.do'
    end
  end

  describe '#base_url' do
    it "is primotest" do
      expect(subject.base_url).to be == "http://primotest.library.nd.edu"
    end
  end

  describe '#url' do
    it "includes the base_url, path, and query_string" do
      expect(subject.url).to be == "#{subject.base_url}#{subject.path}#{subject.query_string}"
    end
  end

  describe 'production' do
    before do
      described_class.stub(:config_name).and_return('production')
    end

    describe '#base_url' do
      it "is onesearch for NDU" do
        subject.stub(:institution).and_return('NDU')
        expect(subject.base_url).to be == "http://onesearch.library.nd.edu"
      end

      it "is catalogplus for non-NDU" do
        subject.stub(:institution).and_return('SMC')
        expect(subject.base_url).to be == "http://catalogplus.library.nd.edu"
      end
    end
  end
end