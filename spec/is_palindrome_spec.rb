def is_palindrome_string?(given_string, is_case_sensitive=false)
  return false if given_string.blank?
  clean_string = given_string.strip
  clean_string = clean_string.downcase if not is_case_sensitive

  return clean_string == clean_string.reverse
end

# spec/is_palindrome_string_spec.rb
# require 'spec_helper'
require 'rails_helper'

shared_examples :testing_palindrome_string do |options = {}|
  it "returns #{options[:expected]}" do
    expect(is_palindrome_string?(given_string, options[:case_sensitive])).to eq(options[:expected])
  end
end

describe "testing is_palindrome_string?" do
  let(:given_string) { nil }

  describe "when checking an invalid palindrome string" do
    context "when string is nil" do
      it_behaves_like :testing_palindrome_string, expected: false
    end

    context "when string is empty" do
      let(:given_string) { '' }
      it_behaves_like :testing_palindrome_string, expected: false
    end

    context "when string has leading/trailing white space" do
      let(:given_string) { '  Hello World! ' }
      it_behaves_like :testing_palindrome_string, expected: false
    end

    context "when string is normal" do
      let(:given_string) { 'Hello World!' }
      it_behaves_like :testing_palindrome_string, expected: false
    end

    context "when string has spaces and punctuation" do
      let(:given_string) { 'A man, a plan, a canal, Panama' }
      it_behaves_like :testing_palindrome_string, expected: false
    end
  end

  describe "when checking a valid palindrome string" do
    context "when string is normal" do
      let(:given_string) { 'abba' }
      it_behaves_like :testing_palindrome_string, expected: true
    end

    context "when string has leading/trailing white space" do
      let(:given_string) { '  abba ' }
      it_behaves_like :testing_palindrome_string, expected: true
    end
  end

  describe "when checking with case sensitivity" do
    context "when string has matching upper-case" do
      let(:given_string) { 'aBBa' }
      it_behaves_like :testing_palindrome_string, case_sensitive: true, expected: true
    end

    context "when string does not match upper-case" do
      let(:given_string) { 'abBa' }
      it_behaves_like :testing_palindrome_string, case_sensitive: true, expected: false
    end
  end
end