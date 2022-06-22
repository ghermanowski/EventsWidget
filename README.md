# EventsWidget

A recreation of the iOS Calendar app's widget, that shows today's remaining events using EventKit. Includes widget configuration to limit the events only to selected calendars.

<div>
  <img width="30%" alt="EventsWidget next to Calendar's widget" src="https://user-images.githubusercontent.com/57409167/162175822-7066dd9e-762c-4381-82a6-6bb49372c6d7.png">
  <img width="30%" alt="Widget configuration" src="https://user-images.githubusercontent.com/57409167/162176048-68b33e7c-91df-4982-a138-c2f2bbcb8946.png">
</div>

Created at Apple Developer Academy Napoli

### Technologies

SwiftUI, WidgetKit, EventKit


## Tutorial: How to Create Configurable Widgets

In this tutorial you will learn how to allow your users to configure their widgets. I will show you how to add configuration to an already existing widget in your app.

### 0 — Create a Widget Extension

*If you do not have a widget yet, you can create include the configuration while creating the widget extension, which allows you to skip step 2.*

<img width="95%" alt="Creating a new widget extension" src="https://user-images.githubusercontent.com/57409167/161965775-8961ca00-6784-41f2-868b-18b4eaf11a99.png">
<img width="95%" alt="Provide a name for your widget" src="https://user-images.githubusercontent.com/57409167/161965940-ff418982-ef49-470e-87a6-8c0adee488d1.png">

### 1 — Add a Configuration Intent

To allow configuration of your widgets, you need to add a new target to your project. Choose the template "Intents Extension".

<img width="95%" alt="Adding a configuration intent" src="https://user-images.githubusercontent.com/57409167/161966090-5dcee556-91d3-4b64-97f5-98d5e1fc1c97.png">

### 2 — Add a SiriKit Intent Definition

Right click on a file inside the Widget group to add the intent definition file.

<img width="95%" alt="Adding a SiriKit intent" src="https://user-images.githubusercontent.com/57409167/161966304-5089d60c-a564-43ee-a6f8-87d088f90b4e.png">

Make sure to include it in all your targets.

<img width="95%" alt="Adding a new intent target" src="https://user-images.githubusercontent.com/57409167/161966357-001a2d22-188e-4648-a1c4-331db99edfac.png">

### 3 — Add Configuration Options

Inside the the intent definition, add a new intent for the configuration of your widget.

<img width="95%" alt="Adding a new intent" src="https://user-images.githubusercontent.com/57409167/161966457-c8893a60-5997-4e94-afd7-6ea99de52245.png">

In the first section, click the checkbox "Intent is eligible for widgets" and deselect the others as we do not need them.

<img width="95%" alt="Configuring the configuration" src="https://user-images.githubusercontent.com/57409167/161966523-ef7909b3-f3df-4dd1-b3d7-a18a76ccaca5.png">

Add your options for configuration in the Parameters section. Here, we will add a boolean value.

<img width="95%" alt="Adding a parameter" src="https://user-images.githubusercontent.com/57409167/161966604-16dde4ec-1934-4f25-a717-89304a4cc662.png">

You can also create custom types that you use in your widget. 

<img width="95%" alt="Creating a custom type" src="https://user-images.githubusercontent.com/57409167/161966719-9c860472-bed4-4221-a36e-d7c6ab2fed00.png">
<img width="95%" alt="Configuring the options" src="https://user-images.githubusercontent.com/57409167/161966791-a883a78e-8add-410c-bbfe-a551c438c19d.png">

In [step 9](#9--dynamic-options) we will add dynamic options provided by your app.

You can also hide options conditionally by setting a parent parameter for them.

### 4 — Add the Configuration to the Widget Entry

Add a constant to the entry.

<img width="95%" alt="Adding configuration constant" src="https://user-images.githubusercontent.com/57409167/161967824-169ad798-bfeb-4af8-95b7-992777af08cd.png">

### 5 — Update Provider

Change its type to `IntentTimelineProvider`.

<img width="95%" alt="Replacing the provider type" src="https://user-images.githubusercontent.com/57409167/161968025-dae45419-a209-4ae4-b961-453dfc31f250.png">

To adapt to the protocol, you need to add `for configuration: ColourWidgetConfigurationIntent` as the first parameter of the methods `getSnapshot` and `getTimeline`.

Next, pass the configuration parameter to the entry initialisers. In the `placeholder` method, you can initialise a new value of your configuration type. 

<img width="95%" alt="Completed Provider" src="https://user-images.githubusercontent.com/57409167/161968132-2d51e0be-775d-486c-83af-51eafa2fe553.png">

### 6 — Update Widget

Replace `StaticConfiguration` with `IntentConfiguration` in the widget struct and fill in the parameters like this:

<img width="95%" alt="Completed Widget" src="https://user-images.githubusercontent.com/57409167/161968283-af4d2839-409d-4e32-9d26-5d65cbc5ece7.png">

### 7 — Test in the Simulator

Run the widget extension — not the intent — to test if the configuration appears correctly in the simulator.

<div>
  <img width="30%" alt="After pressing on the widget" src="https://user-images.githubusercontent.com/57409167/161968416-3201e058-b124-47a9-bdd9-4188c005607d.png">
  <img width="30%" alt="Editing the widget's configuration" src="https://user-images.githubusercontent.com/57409167/161968431-85606680-4a0c-4250-b9a7-fa60e057ec01.png">
</div>

### 8 — Use the Configuration Info

Now you can use the values inside the entry view of the widget. 

*Note that any boolean values from your configuration will be represented as `NSNumbers`. 0 is false and 1 is true.*

<img width="95%" alt="Using the configuration info" src="https://user-images.githubusercontent.com/57409167/161969551-f45b6aef-3f2c-45f7-bbbc-cab273c95b7d.png">

### 9 — Dynamic Options

Adding options that are provided dynamically by your app is possible as well. Let's replace our enum `Colour` with a new type `DynamicColour` and select "Options are provided dynamically".

<img width="95%" alt="Replacing static options" src="https://user-images.githubusercontent.com/57409167/161974160-9bff68ab-3c2c-48a4-8cff-df7d3271cb34.png">

### 10 — Provide Dynamic Options

Open IntentHandler.swift. You can remove the method `handler` because we will not use it. 

Adapt the class to your app's handling protocol, which was generated automatically for you. Add a method to provide the options. Xcode will suggest you the method name, which will autogenerate it.

<img width="95%" alt="Adapting the handling protocol" src="https://user-images.githubusercontent.com/57409167/161969744-914e4a22-32c3-449a-818f-cf7b4b1057eb.png">

To use options from your app, the file that provides the data needs to include the intent in its targets. In this tutorial I will use a static array of colours. You need to convert the type of your app's date to the type used in the struct. Using `map` is ideal for this.

<img width="95%" alt="Mapping the values" src="https://user-images.githubusercontent.com/57409167/161969847-01c7ee4a-bff5-4107-8b86-f7d6219fe19d.png">

You can also provide a value that is selected by default. As in the previous step, Xcode will suggest you a name for it.

<img width="95%" alt="Providing a default value" src="https://user-images.githubusercontent.com/57409167/161969939-67acc22b-4310-4eab-8006-97955f3da90e.png">

### 11 — Use the Dynamic Options

In your widget entry view, you will need to change the type to the dynamic value.

<img width="95%" alt="Using the dynamic options" src="https://user-images.githubusercontent.com/57409167/161970011-d323efa4-f094-478c-baee-72f878f79936.png">

### 12 — Run

And that's it. The options should now be available in your widget's configuration when you run it in the simulator.

<div>
  <img width="30%" alt="Editing the widget" src="https://user-images.githubusercontent.com/57409167/161970110-d3899b56-6f8b-4d8e-891f-ca7604429ddf.png">
  <img width="30%" alt="Selecting from the dynamic options" src="https://user-images.githubusercontent.com/57409167/161970122-02c5aa7f-d4d8-4413-972c-872562451e4b.png">
</div>

### Conclusion

You now know how to add configuration options to your widgets and even how to provide them dynamically. If you want to find out how to allow multiple options to be selected, take a look at my project, EventsWidget. In it, I recreated the widget from the Calendar app, which shows you today's remaining events. The widget can be configured to only show events from certain calendars. The data is fetched using EventKit, which allows access to events stored in Calendar. I also used ContainerRelativeShape to make sure that the corner radius of the events matches that of the widget.
