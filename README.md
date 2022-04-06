# EventsWidget

A recreation of the iOS Calendar app's widget, that shows today's remaining events. Includes configuration to limit the events to only selected calendars.

Created at Apple Developer Academy Napoli


## Tutorial: How to Create Configurable Widgets

In this tutorial you will learn how to allow your users to configure their widgets. I will show you how to add configuration to an alredy existing widget in your app.

### 0 — Create a Widget Extension

*If you do not have a widget yet, you can create include the configuration while creating the widget extension, which allows you to skip to __STEP NUMBER__.*

__Screenshot__

### 1 — Add a Configuration Intent

To allow configuration of your widgets, you need to add a new target to your project. Choose the template Intents Extension.

__Screenshot__

### 2 — Add a SiriKit Intent Definition

Right click inside the Widget group to add the intent definition file.

__Screenshot__

Make sure to include it in all your targets.

__Screenshot__

### 3 — Add Configuration Options

Inside the the intent definition, add a new intent for the configuration of your widget.

__Screenshot__

In the first section, click the checkbox "Intent is elligible for widgets" and deselect the others as we do not need them.

__Screenshot__

Add your options for configuration in the Parameters section. Here, we will add a boolean value.

__Screenshot__

You can also create custom types that you use in your widget. 

__Screenshot__
__Screenshot__

In __STEP NUMBER__ we will add dynamic options provided by your app.

You can also hide options conditionally by setting a parent parameter for them.

### 4 — Add the Configuration to the Widget Entry

__Screenshot__ 

### 5 — Update Provider

Change its type to IntentTimelineProvider.

__Screenshot__ 

To adapt to the protocol, you need to add `for configuration: ColourWidgetConfigurationIntent` as the first parameter of the methods `getSnapshot` and `getTimeline`.

Next, pass the configuration parameter to the entry initialisers. In the `placeholder` method, you can initialise a new value of your configuration type. 
__Screenshot__ 

### 6 — Update Widget

Replace StaticConfiguration with IntentConfiguration and fill in the parameters like this:

__Screenshot__ 

### 7 — Test in the Simulator

Run the widget extension — not the intent — to test if the configuration appears correctly in the simulator.

__Screenshot__ 
__Screenshot__ 

### 8 — Use the Configuration

Now you can use the values inside the entry view of the widget. 

*Note that any boolean values from your configuration will be represented as NSNumbers. 0 is false and 1 is true.*

__Screenshot__ 

### 9 — Dynamic Options

Adding options that are provided dynamically by your app is possible as well. Let's replace the enum Colour with a new type DynamicColour and select "Options are provided dynamically".

__Screenshot__ 

### 10 — Provide Dynamic Options

Open IntentHandler.swift. You can remove the method `handler` because we will not use it. 

Adapt the class to your app's Handling protocol, which was generated automatically for you. Add a method to provide the options. Xcode will suggest you the method name, which will autogenerate it.

To use options from your app, the file that provides the data needs to include the intent in its targets. In this tutorial I will use a static array of colours. You need to convert the type of your app's date to the type used in the struct. Using `map` is ideal for this.

__Screenshot__ 

You can also provide a value that is selected by default. As in the previous step, Xcode will suggest you a name for it.

__Screenshot__ 

### 11 — Use the Dynamic Options

In your widget entry view, you will need to change the type to the dynamic value.

__Screenshot__ 

### 12 — Run

And that's it. The options should now be available in your widget's configuration when you run it in the simulator.

__Screenshot__ 

### Conclusion

You now know how to add configuration options to your widgets and even how to provide them dynamically. If you want to find out how to allow multiple options to be selected, take a look at my project, EventsWidget. In it, I recreated the widget from the Calendar app. The widget can be configured to only show events from certain calendars.
