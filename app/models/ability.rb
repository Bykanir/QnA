# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer], author: user
    can :destroy, [Question, Answer], author: user
    can :best, Answer, question: { author: user }
    can %i[voted_for voted_against revote], [Question, Answer]
    cannot %i[voted_for voted_against revote], [Question, Answer], author: user
    can :destroy, Link, linkable: { author: user }
  end
end
