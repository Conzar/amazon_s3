require 'spec_helper'
describe 'amazon_s3' do

  context 'with defaults for all parameters' do
    it { should contain_class('amazon_s3') }
  end
end
