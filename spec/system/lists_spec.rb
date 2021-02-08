# frozen_string_literal: true

require 'rails_helper'

describe "投稿のテスト" do
  let!(:blog) {create(:blog, title: 'hoge', category: 'category', body: 'body')}

  describe "トップ画面、投稿一覧(root_path)のテスト" do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(blogs_path)に「Recent Blogs」が表示されているか' do
        expect(page).to have_content 'Recent Blogs'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
      it '投稿されたものが表示されているか' do
        expect(page).to have_content blog.title
        expect(page).to have_link blog.title
      end
    end
  end

  describe "投稿画面(new_blog_path)のテスト" do
    before do
      visit new_blog_path
    end
    context '表示の確認' do
      it 'new_blog_pathが"/blogs/new"であるか' do
        expect(current_path).to eq('/blogs/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'blog[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'blog[category]', with: Faker::Lorem.characters(number: 10)
        fill_in 'blog[body]', with: Faker::Lorem.characters(number: 30)
        click_button '投稿'
        expect(page).to have_current_path blog_path(Blog.last)
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      visit blog_path(blog)
    end
    context '表示の確認' do
      it '削除リンクは存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクは存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/blogs/' + blog.id.to_s + '/edit')
      end
    end
    context 'blog削除のテスト' do
      it 'blogの削除' do
        expect{blog.destroy}.to change{Blog.count}.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_blog_path(blog)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示されている' do
        expect(page).to have_field 'blog[title]', with: blog.title
        expect(page).to have_field 'blog[category]', with: blog.category
        expect(page).to have_field 'blog[body]', with: blog.body
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'blog[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'blog[category]', with: Faker::Lorem.characters(number: 10)
        fill_in 'blog[body]', with: Faker::Lorem.characters(number: 30)
        click_button '保存'
        expect(page).to have_current_path blog_path(blog)
      end
    end
  end
end