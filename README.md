# Acts as Constrained

This gem includes the requried scopes and behaviours to allow to filter models
using different criteria (even your own criteria).

In the end they're just a bunch of scopes and concerns so it may seem a rather
uninteresting tool, but it's aimed on normalizing all the filtering behaviours
and create a simple way to chain a lot of variable filters.

## Install

Currently we don't have a published gem so you should use it through your
Gemfile.

```ruby
  gem "acts-as-constrained", git: 'git@github.com:simplelogica/acts_as_constrained.git'
```

## Usage

In order to use it you just have to add the
`ActsAsConstrained::Concerns::Constrained` concern to your model and add
constraints using the `constrained_by` method.

```ruby
class Offer < ActiveRecord::Base

  include ActsAsConstrained::Concerns::Constrained

  constrain_by :single_date
  constrain_by :model

end
```

## Constraints

Currently there are 3 implemented constraints: by multiple dates, a single date
and another linked model.

### Multiple Dates

It's implemented in the `ActsAsConstrained::Concerns::DateConstraint` concern.

It uses the `ActsAsConstrained::DateConstraint` model to store the periods of
time where each object is valid and provides a scope to constrain a model
according to a date.

### Single Date

It's implemented in the `ActsAsConstrained::Concerns::SingleDateConstraint`
concern.

It uses two attributes in the same model to perform a filter according to a
date. The main difference with the MultipleDate is that you can't assign more
than one period.

In order to use this constrain you have to generate a migraiton for those
fields. This engine provides a generator for that:

```
rails g acts_as_constrained:single_date_migration offer
```

### Model

It allows to create a relationship between the constrained model and another one
and retrieve only the records related with a constraining object.

## Additional constraints

You can extend this engine behaviour by creating new concerns and scopes.

The concern should follow the naming convection
`ActsAsConstrained::Concerns::MyConstraint` replacing `My` with any word you like.

This concern must define a scope `constrained_by_my` replacing `my` with the
underscored version of the name you gave to the concern. This scope is
responsible of doing all the filtering job.

This constraint then can be included by using the `constrained_by :my` sentence
in the model (yes, replacing my` with the underscored version of the name you
gave to the concern).

Here's an example:

```ruby
  module ActsAsConstrained::Concerns::CategoryConstraint

    extend ActiveSupport::Concern

    included do

      has_many :categories

      scope :constrained_by_category, ->(time = Time.now) do
        joins(:categories).where(
          categories: { published: true }
        )
      end

    end

  end
```

```ruby
  class NewsItem < ActiveRecordBase

    include ActsAsConstrained::Concerns::Constrained

    constrain_by :category

  end
```

If you don't want to create a concern you can just create the `constrained_by`
scope and not use the `constrain_by` sentence.

The previous code would be equivalent to

```ruby
  class NewsItem < ActiveRecordBase

    include ActsAsConstrained::Concerns::Constrained

    has_many :categories

    scope :constrained_by_category, ->(time = Time.now) do
      joins(:categories).where(categories: { published: true })
    end

  end
```

In both cases you could do now

```ruby
  NewsItem.constrained_by(category: [category1, category2])
```
