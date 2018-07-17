This is a POC (Proof of Concept) project.

To prove the following idea

- Simple DI
- Replaceable factory class
- Default is name bases COC (Convention over Configuration)

## Factory Container

- Singleton
- Holds factory classes in the hash
- A factory classes is replaceable
  - Mostly used for unit testing

## Factory

- Can have BaseFactory as a parent for the default behavior
- Can implement original factory

If you want the factory class behave as default

```my_factory.rb
class MyFactory < BaseFactory
end
```

, or you want an original factory, let the class have `create` method

```my_factory.rb
class MyFactory
  def create
    c = My.new
    // do something original
    c
  end
end
```
