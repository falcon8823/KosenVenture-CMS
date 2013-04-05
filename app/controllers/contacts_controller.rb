# encoding: utf-8

class ContactsController < ApplicationController
  layout 'kvp'

  # GET /contact
  def show
    @site_title = '高専ベンチャー'
    @page_title = 'お問い合わせ'
    @contact = Contact.new
  end

  # POST /contact
  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      # TODO : send mail

      redirect_to root_url, notice: 'お問い合わせ内容を送信しました。'
    else
      render :show
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name_kanji, :name_kana, :email, :affiliation, :body)
  end
end