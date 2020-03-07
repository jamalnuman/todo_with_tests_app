require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it 'should change complete from false to true' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end

    it 'should change complete from true to false' do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end

  describe '#toggle_favorite' do
    it 'should change favorite from true to false' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should change favorite from false to true' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    it 'should return true if the time is past the deadline' do
      task = Task.create(deadline: Time.now - 1.hour)
      #task = Task.create(deadline: 1.hour.ago)
      #ttask.overdue?
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if the time is not past the deadline' do
      task = Task.create(deadline: Time.now + 1.hour)
      task = Task.create(deadline: 1.hour.from_now)
      #task.overdue?
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should increase the priority level, if under 10' do
      task = Task.create(priority: 9)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end

    it 'should not increment, if the priority is 10' do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do 
    it 'should decrease the priority level, if above 1' do
      task = Task.create(priority: 2)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end

    it 'should not decrease the priority level, if at 1' do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do 
    it 'should increase the deadline by 1 hour' do
      task = Task.create(deadline: Time.now)
      compare = task.deadline 
      task.snooze_hour!
      expect(task.deadline).to eq(compare + 1.hour)
    end
  end
end
