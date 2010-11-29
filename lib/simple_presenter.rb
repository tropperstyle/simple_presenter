module SimplePresenter
  def self.included(base)
    base.extend(ClassMethods)
  end

  # Add Presenter Pattern to models. Add
  #   define_presentation :with => SomeModule
  # to your model class, where SomeModule contains the methods that contain
  # your presentation logic. The methods defined are extended into
  # a duplicate of your model, so you can safely override methods and simply call super
  # to retrieve the original value.
  # 
  # Example:
  #   class User
  #     include SimplePresenter
  #     define_presentation :with => UserPresenter
  #     
  #     def name
  #       "Jane Doe"
  #     end
  #   end
  #
  #   module UserPresenter
  #     def name
  #       "#{super} is being presented"
  #     end
  #   end

  module ClassMethods
    # Options:
    #   :with - Specifies a module, or array of modules, which include methods that contain the presentation logic.
    #     You may access these methods via the instance method present.
    #
    # You may also use an anonymous module by passing a block
    #
    # Examples:
    #   class User
    #     include SimplePresenter
    #     define_presentation :with => UserPresenter do
    #       def hello
    #         "I can also be accessed through @user.present(:hello)"
    #       end
    #     end
    #   end
    def define_presentation(options = {}, &block_extension)
      options.assert_valid_keys(:with)
      define_attribute_methods
      class_inheritable_accessor :presenter_modules
      self.presenter_modules = create_presentation_modules(options[:with], block_extension)
    end

    def create_presentation_modules(modules, block_extension)
      modules = Array(modules)
      if block_extension
        const_set(:PresenterExtension, Module.new(&block_extension))
        modules.push("#{self}::PresenterExtension".constantize)
      else
        modules
      end
    end
  end

  # This method is used to access your presentation methods.
  # Example:
  #   @user = User.new
  #   @user.present(:name)
  #
  def present(attribute, *args)
    presenter.send(attribute, *args)
  end

  private
  def presenter
    @presenter ||= dup.extend(*self.class.presenter_modules)
  end
end
