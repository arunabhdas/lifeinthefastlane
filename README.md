# LifeInTheFastLane

LifeInTheFastLane is a tutorial for fastlane 
https://github.com/fastlane/fastlane
created by Felix Krause
https://krausefx.com/about/

## Prerequisites

Ruby 2.0 is required
$ ruby -v

Xcode CLT is required
$ xcode-select --install

## Installation

sudo gem install fastlane --verbose

## Overview

produce creates new iOS apps in both iTunes Connect and the Apple Developer Portal.
cert automatically creates and maintains iOS code signing certificates.
sigh creates, renews, downloads and repairs provisioning profiles.
snapshot automates taking localized screenshots of your iOS app on every device.
frameit puts your screenshots into the right device frames.
gym builds and packages your iOS apps.
deliver uploads screenshots, metadata and your apps to the App Store.
PEM automatically generates and renews your push notification profiles.



## Setup

==> fastlane init


Do you want to get started? This will move your Deliverfile and Snapfile (if they exist) (y/n)
Enter y
Do you have everything committed in version control? If not please do so!
Enter y
App Identifier (com.krausefx.app):
Enter a unique app ID. Keep this app ID handy, as you will need it later!
Your Apple ID (fastlane@krausefx.com):
Enter your Apple ID
Do you want to setup ‘deliver’, which is used to upload app screenshots, app metadata and app updates to the App Store or Apple TestFlight? (y/n)
Enter n
Do you want to setup ‘snapshot’, which will help you to automatically take screenshots of your iOS app in all languages/devices? (y/n)
Enter y
Do you want to use ‘sigh’, which will maintain and download the provisioning profile for your app? (y/n)
Enter y
Optional: The scheme name of your app: (If you don’t need one, just hit Enter.)
Press enter


This generates the following files :

Appfile, which stores the app identifier and your Apple ID.
Fastfile, which manages the lanes you create to call certain actions.
Snapfile, which lets you specify the devices and languages you want to provide screenshots for.

Replace Fastfile contents with the following contents 

# Minimum version of fastlane
fastlane_version "1.32.1"
 
default_platform :ios
 
platform :ios do
 
  # 1 
  desc "Creating a code signing certificate and provisioning profile"
  # 2
  lane :provision do
    # 3 
    produce(
      app_name: 'HomeControlApp',
      language: 'English',
      app_version: '1.0',
      sku: '123abc'
    )
    # 4
    cert
    # 5
    sigh(force: true)
  end
 
  error do |lane, exception|
    # This block is called, if there was an error running a specific lane.
  end
 
end


==> fastlane provision
[09:44:31]: -------------------------------------------------
[09:44:31]: --- Step: Verifying required fastlane version ---
[09:44:31]: -------------------------------------------------
[09:44:31]: fastlane version valid
[09:44:31]: ------------------------------
[09:44:31]: --- Step: default_platform ---
[09:44:31]: ------------------------------
[09:44:31]: Driving the lane 'ios provision' 🚀
[09:44:31]: ---------------------
[09:44:31]: --- Step: produce ---
[09:44:31]: ---------------------

+----------------+--------------------------------------+
|               Summary for produce 1.1.2               |
+----------------+--------------------------------------+
| app_name       | HomeControlApp                       |
| language       | English                              |
| app_version    | 1.0                                  |
| sku            | 123abc                               |
| username       | arunabhdas@gmail.com                 |
| app_identifier | com.arunabhdas.mobile.HomeControlApp |
| skip_itc       | false                                |
| skip_devcenter | false                                |
+----------------+--------------------------------------+

[09:44:34]: Creating new app 'HomeControlApp' on the Apple Dev Center
[09:44:34]: Created app 76TGK8WMLA
[09:44:35]: Finished creating new app 'HomeControlApp' on the Dev Center
[09:44:37]: Creating new app 'HomeControlApp' on iTunes Connect
[09:44:38]: Successfully created new app 'HomeControlApp' on iTunes Connect with ID 1123445691
[09:44:38]: ------------------
[09:44:38]: --- Step: cert ---
[09:44:38]: ------------------

+---------------+-----------------------------------------------+
|                    Summary for cert 1.4.1                     |
+---------------+-----------------------------------------------+
| development   | false                                         |
| force         | false                                         |
| username      | arunabhdas@gmail.com                          |
| keychain_path | /Users/coder/Library/Keychains/login.keychain |
+---------------+-----------------------------------------------+

[09:44:38]: Starting login with user 'arunabhdas@gmail.com'
[09:44:40]: Successfully logged in
[09:44:40]: Couldn't find an existing certificate... creating a new one
[09:44:41]: $ security import /Users/coder/repos/ad/githubrepos/lifeinthefastlane/HomeControl/H67R5W67US.p12 -k '/Users/coder/Library/Keychains/login.keychain' -T /usr/bin/codesign -T /usr/bin/security
[09:44:42]: ▸ 1 key imported.
[09:44:42]: $ security import /Users/coder/repos/ad/githubrepos/lifeinthefastlane/HomeControl/H67R5W67US.cer -k '/Users/coder/Library/Keychains/login.keychain' -T /usr/bin/codesign -T /usr/bin/security
[09:44:42]: ▸ 1 certificate imported.
[09:44:42]: Successfully generated H67R5W67US which was imported to the local machine.
security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain.
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1062  100  1062    0     0   1778      0 --:--:-- --:--:-- --:--:--  1778
[09:44:45]: Verifying the certificated is properly installed locally...
[09:44:45]: Successfully installed certificate H67R5W67US
[09:44:45]: Use signing certificate 'H67R5W67US' from now on!
[09:44:45]: ------------------
[09:44:45]: --- Step: sigh ---
[09:44:45]: ------------------

+-------------------------------------+--------------------------------------+
|                           Summary for sigh 1.8.0                           |
+-------------------------------------+--------------------------------------+
| force                               | true                                 |
| adhoc                               | false                                |
| skip_install                        | false                                |
| development                         | false                                |
| app_identifier                      | com.arunabhdas.mobile.HomeControlApp |
| username                            | arunabhdas@gmail.com                 |
| ignore_profiles_with_different_name | false                                |
| cert_id                             | H67R5W67US                           |
| skip_fetch_profiles                 | false                                |
| skip_certificate_verification       | false                                |
+-------------------------------------+--------------------------------------+

[09:44:45]: Starting login with user 'arunabhdas@gmail.com'
[09:44:47]: Successfully logged in
[09:44:47]: Fetching profiles...
[09:44:48]: No existing profiles found, that match the certificates you have installed locally! Creating a new provisioning profile for you
[09:44:50]: Creating new provisioning profile for 'com.arunabhdas.mobile.HomeControlApp' with name 'com.arunabhdas.mobile.HomeControlApp AppStore'
[09:44:52]: Downloading provisioning profile...
[09:44:52]: Successfully downloaded provisioning profile...
[09:44:52]: Installing provisioning profile...
/Users/coder/repos/ad/githubrepos/lifeinthefastlane/HomeControl/AppStore_com.arunabhdas.mobile.HomeControlApp.mobileprovision
[09:44:52]: Setting Provisioning Profile type to 'app-store'

+------+-------------------------------------+-------------+
|                     fastlane summary                     |
+------+-------------------------------------+-------------+
| Step | Action                              | Time (in s) |
+------+-------------------------------------+-------------+
| 1    | Verifying required fastlane version | 0           |
| 2    | default_platform                    | 0           |
| 3    | produce                             | 7           |
| 4    | cert                                | 6           |
| 5    | sigh                                | 7           |
+------+-------------------------------------+-------------+

[09:44:52]: fastlane.tools finished successfully 🎉

# Snapshot
Follow the steps described here 
https://tisunov.github.io/2015/11/06/automating-app-store-screenshots-generation-with-fastlane-snapshot-and-sketch.html

and

http://code.tutsplus.com/tutorials/how-to-automate-screenshots-with-fastlane--cms-26151

$ snapshot init

Replace the contents of Snapfile with the following contents 

# A list of devices you want to take the screenshots from
devices([
  "iPhone 4s",
  "iPhone 5",
  "iPhone 6",
  "iPhone 6 Plus"
])
 
# A list of supported languages
languages([
  'en-US',
  'fr-FR'
])
 
# Where should the resulting screenshots be stored?
output_directory "../screenshots"
 
# Clears previous screenshots
clear_previous_screenshots
 
# Latest version of iOS
ios_version '9.1'


Open the Fastfile and add the following code right above error do |lane, exception|:
desc "Take screenshots"
lane :screenshot do
  snapshot
end



$ snapshot 



