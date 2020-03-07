require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Shooping List")
      Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      expect(list.tasks[0].complete).to eq(true)
      #list.tasks.each do |task|
        #expect(task.complete).to eq( true)
      #The following is because of the associations..where the task is the ruby object and list.task is the instance inside the database.remember the test has to be executed on the instance within the database and not the ruby object. 
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should add an hour to the deadline of each task' do
      list = List.create(name: "Shooping list")
      time_stamps = [ Time.now, 30.minutes.ago]

      time_stamps.each do |time_stamp|
        Task.create(deadline: time_stamp, list_id: list.id)
      end

      # Task.create(deadline: compare, list_id: list.id)
      # Task.create(deadline: compare, list_id: list.id)
      list.snooze_all_tasks!

      list.tasks.each_with_index do |task, index| 
        expect(task.deadline).to eq(time_stamps[index] + 1.hour)
      end
      #expect(list.tasks[0].deadline).to eq(compare + 1.hour)
    end
  end

  describe '#total_duration' do
    it 'should return the sum of all the durations of the tasks' do
      list = List.create(name: "Shooping list")
      Task.create(duration: 40, list_id: list.id)
      Task.create(duration: 40, list_id: list.id)

      expect(list.total_duration).to eq(80)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of all incomplete tasks' do
      list = List.create(name: "Shooping list") 
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)


      expect(list.incomplete_tasks.length).to eq(2)
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of favorite tasks' do 
      list = List.create(name: "Shooping list")
      Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: true, list_id: list.id)

      expect(list.favorite_tasks.length).to eq(2)
    end
  end












end
