require 'rails_helper'

describe QuicksearchController do
  describe '#subject' do
    before do
      stub_ddw_quicksearch_terms
    end

    describe 'NullDB' do
      include NullDB::RSpec::NullifiedDatabase

      describe 'known subject' do
        before do
          @term = DDWTerm.quicksearch_terms.first
          @target = @term.xerxes_path
        end

        it "redirects to the library" do
          get :subject, target: @target
          expect(response).to be_redirect
          expect(response).to redirect_to(@term.articles_url)
        end
      end

      describe 'unknown subject' do
        before do
          @target = "/quicksearch/databases/subject/fakesubject"
        end

        it "redirects to xerxes" do
          get :subject, target: @target
          expect(response).to be_redirect
          expect(response).to redirect_to(xerxes_url(@target))
        end

        it "sends an error email" do
          lambda {
            get :subject, target: @target
          }.should change(ActionMailer::Base.deliveries, :size).by(1)
        end
      end

      describe 'no target' do
        it "redirects to xerxes" do
          get :subject
          expect(response).to be_redirect
          expect(response).to redirect_to(xerxes_url("/quicksearch/"))
        end

        it "does not send an error email" do
          lambda {
            get :subject
          }.should change(ActionMailer::Base.deliveries, :size).by(0)
        end
      end

      describe 'database target' do
        before do
          @target = "/quicksearch/databases/database/NDU05514"
        end
        it "redirects to xerxes" do
          get :subject, target: @target
          expect(response).to be_redirect
          expect(response).to redirect_to(xerxes_url(@target))
        end

        it "does not send an error email" do
          lambda {
            get :subject, target: @target
          }.should change(ActionMailer::Base.deliveries, :size).by(0)
        end
      end
    end

    def xerxes_url(path)
      "http://#{Rails.configuration.xerxes_domain}#{path}"
    end
  end
end
