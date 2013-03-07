require 'test_helper'

class InvitesControllerTest < ActionController::TestCase
  setup do
    @invite = invites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invite" do
    assert_difference('Invite.count') do
      post :create, invite: { cookie: @invite.cookie, email: @invite.email, inviter_id: @invite.inviter_id, invites_count: @invite.invites_count, short_url: @invite.short_url, site_id: @invite.site_id, unique_code: @invite.unique_code, views_count: @invite.views_count }
    end

    assert_redirected_to invite_path(assigns(:invite))
  end

  test "should show invite" do
    get :show, id: @invite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invite
    assert_response :success
  end

  test "should update invite" do
    put :update, id: @invite, invite: { cookie: @invite.cookie, email: @invite.email, inviter_id: @invite.inviter_id, invites_count: @invite.invites_count, short_url: @invite.short_url, site_id: @invite.site_id, unique_code: @invite.unique_code, views_count: @invite.views_count }
    assert_redirected_to invite_path(assigns(:invite))
  end

  test "should destroy invite" do
    assert_difference('Invite.count', -1) do
      delete :destroy, id: @invite
    end

    assert_redirected_to invites_path
  end
end
