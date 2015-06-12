# Swift SDK FAQ

##RingCentral Summer Internship Program
***

1. [Swift SDK](#swiftSDK)
2. [Swift SDK Demo](#swiftSDKDemo)
3. [Swift SDK Larger Demo](#swiftSDKLargerDemo)
4. [Other Applications](#otherApplications)
5. [etc.](#etc)

***

### 1. Swift SDK

Contains two classes within that structures the SDK.

The basic idea is that the “User” is a key to “Platform”.
Every call in platform.swift will require a “User”.
If the user has the wrong credentials, it will return an error.

 + user.swift

This acts as a user object. Contains the information that a regular person would have.
Stores: app_key, app_secret, username, password, tokens
The “User” object is made depending on what the user puts in.
Essentially this is used as a key to access “platform”.

 + platform.swift

(A simpler wrapper is being constructed.)

This platform allows sending of HTTP requests.

(Specific testing classes will be added later.

 + Method calls

oauth:		gives the appropriate token (one accessToken, one refreshToken)
		uses the refreshToken to obtain a new accessToken

revoke:		terminates the given token

version:	returns the api version that the RingCentral API is currently using

accountId:	returns the accountId of the token passed in
		allows for other calls (in combination with extensionId)

callLog:	returns the call log
		allows for other calls with extension, convoId, and other specifications

SMS:		allows the user to send SMS to a specific person
		the “From” must be an authentic number registered within RingCentral API

ringOut:	Connects 2 numbers through RingOut
		When calling, the “From” number will get a call first.
			* if prompted, press 1 to connect call
		“To” person will receive a call from “callerId”
			Once “To” picks up, “To” and “from” will be connected.
		

*messageStore:	Returns the messages for a specific account
		Can be more specific with extensionId or convoId

*fax:		Sends a fax

*companyPager:	Sends a pager (not actually sure if anyone still uses this)

presence:	Checks the presence on a specific account.
		Can be more specific though the addition of the extensionId field.


*subscription:	Subscribes the user to a specific call to have faster constant pings.
		This is used for checking the status of the Users.
		(Presence is pinged once every 30 seconds, which is slower)
		Useful for checking who is currently still in call, and who isn’t.

*addressBook:	Returns the address book of contacts for the given account.

*dictionary:	I really have no idea what the dictionary is.
		From what it looks like, it’s just a FAQ for specific location calling.



- Swift SDK Demo

Contains a basic interface of how to use the basic Swift SDK.
There are one main new class in this file.

 + ViewController.swift (and ViewController2.swift)

This controller gives the user the option to enter the correct credentials.
You need to authorize and login with the correct credentials first.
When the data is passed in, a “User” will be created and sued to access “Platform”.
If the credentials are right, it will perform the specified GET functions.
You will also be able to send SMS and RingOut.

- Swift SDK Larger Demo

This demo elaboarates on what you can do with the Swift SDK.
The main concept of this SDK is that it allows the user to schedules events.
The example given was a Pool Event set up.

 + Steps:

Enter as many phone numbers as you want to send.
Type in the message that you want the recipients to see.
After they receive the message, they will be prompted with a “Time” format.
Once the recipients reply to the SMS message, the program will gather data.
Using the provided data, it will construct a calendar that fits everyone’s times.


- Other Applications

2 Playground files to test around with HTTP requests.
Various ways to send HTTP requests:
	NSURLSession
	NSURLConnection

NSURLSession is recommended as it is the newly updated one. 

- etc.