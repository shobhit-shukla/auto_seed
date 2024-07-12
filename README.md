# AutoSeed

AutoSeed is a Ruby on Rails gem that uses schema comments in the model to automatically generate seed files by running a rake task.

## Features

- Automatically generates seed data based on your Rails models and their schema comments.
- Handles various associations, including `has_many`, `belongs_to`, `has_one`, and polymorphic associations.
- Provides an easy-to-use rake task for seed generation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auto_seed'
```

And then execute:

```
bundle install
```

Or install it yourself as:

```
gem install auto_seed
```

## Usage

To generate the seed file, run the following rake task:

```
rails db:generate_seeds
```

This will create or overwrite the db/seeds.rb file with seed data based on your application's models and their associations.

## Example

Assume you have the following models:

```
class User < ApplicationRecord
  has_many :posts
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
end

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
end
```

Running the `rails db:generate_seeds` task will generate a `db/seeds.rb` file similar to the following:

```
## User seeds
User.create!(
  id: 'sample_value',
  name: 'sample_value',
  email: 'sample_value',
  created_at: 'sample_value',
  updated_at: 'sample_value',
  posts: [Post.create!(...)],
);

## Post seeds
Post.create!(
  id: 'sample_value',
  title: 'sample_value',
  content: 'sample_value',
  created_at: 'sample_value',
  updated_at: 'sample_value',
  user: User.first,
  comments: [Comment.create!(...)],
);

## Comment seeds
Comment.create!(
  id: 'sample_value',
  content: 'sample_value',
  created_at: 'sample_value',
  updated_at: 'sample_value',
  commentable_type: 'Post',
  commentable_id: Post.first.id,
);
```

## Development

To install this gem onto your local machine, run:

```
bundle exec rake install
```

To release a new version, update the version number in version.rb, and then run:

```
bundle exec rake release
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/your_username/auto_seed.

Fork it (https://github.com/your_username/auto_seed/fork)

Create your feature branch (git checkout -b my-new-feature)

Commit your changes (git commit -am 'Add some feature')

Push to the branch (git push origin my-new-feature)

Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgments
Special thanks to all contributors and the open-source community.

## Explanation:

1. **Features**: Lists what the gem can do.
2. **Installation**: Provides instructions for adding the gem to a Rails project.
3. **Usage**: Explains how to use the rake task to generate seed files.
4. **Example**: Demonstrates an example output of the generated seeds file.
5. **Development**: Describes how to install the gem locally and release a new version.
6. **Contributing**: Provides guidelines for contributing to the project.
7. **License**: Mentions the project’s license.

Make sure to replace placeholders such as `your_username` with your actual GitHub username and adjust any other project-specific details as needed.
