# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

Task.destroy_all
Activity.destroy_all
Project.destroy_all
User.destroy_all

@user1 = FactoryBot.create :user
@user2 = FactoryBot.create :user
@user3 = FactoryBot.create :user

@project1 = FactoryBot.create(:project, user: @user1)
@project2 = FactoryBot.create(:project, user: @user2)
@project3 = FactoryBot.create(:project, user: @user2)

@activity1 = FactoryBot.create(:activity, project: @project1)
@activity2 = FactoryBot.create(:activity, project: @project1, status: "current")
@activity3 = FactoryBot.create(:activity, project: @project2)
@activity4 = FactoryBot.create(:activity, project: @project2)
@activity5 = FactoryBot.create(:activity, project: @project3)
@activity6 = FactoryBot.create(:activity, project: @project3, status: "current")
@activity7 = FactoryBot.create(:activity, project: @project3, status: "completed")


@task1 = FactoryBot.create(:task, activity: @activity1)
@task2 = FactoryBot.create(:task, activity: @activity1)
@task3 = FactoryBot.create(:task, activity: @activity1)
@task4 = FactoryBot.create(:task, activity: @activity2)
@task5 = FactoryBot.create(:task, activity: @activity2)
@task6 = FactoryBot.create(:task, activity: @activity3)
@task7 = FactoryBot.create(:task, activity: @activity3)
@task8 = FactoryBot.create(:task, activity: @activity4)
@task9 = FactoryBot.create(:task, activity: @activity4)
@task10 = FactoryBot.create(:task, activity: @activity5)
@task11 = FactoryBot.create(:task, activity: @activity5)
@task12 = FactoryBot.create(:task, activity: @activity6)
@task13 = FactoryBot.create(:task, activity: @activity6)
@task14 = FactoryBot.create(:task, activity: @activity7)
@task15 = FactoryBot.create(:task, activity: @activity7)
