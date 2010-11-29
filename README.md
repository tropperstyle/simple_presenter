SimplePresenter
=========

A simple presentation pattern in ruby.

Overview
--------

Many presentation patterns in ruby seemed to over complicate things.
This is a very simple solution, intended to "decorate" your model methods with a presentaion layer

Usage
-----

Quick example:

    >> test = Simple.new
    => #<Simple:0x10164b368>
    >> test.time
    => Mon Nov 29 15:02:01 -0800 2010
    >> test.present(:time)
    => "November 29, 2010"

    class Simple
      module Present
        def time
          super.strftime('%B %d, %Y')
        end
      end

      include SimplePresenter
      define_presentation :with => Present
  
      def time
        Time.now
      end
    end
