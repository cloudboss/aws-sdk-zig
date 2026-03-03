const aws = @import("aws");

const Action = @import("action.zig").Action;

/// Specifies the settings for a one-time message that's sent directly to an
/// endpoint through the APNs (Apple Push Notification service) channel.
pub const APNSMessage = struct {
    /// The action to occur if the recipient taps the push notification. Valid
    /// values are:
    ///
    /// * OPEN_APP - Your app opens or it becomes the foreground app if it was sent
    ///   to the background. This is the default action.
    /// * DEEP_LINK - Your app opens and displays a designated user interface in the
    ///   app. This setting uses the deep-linking features of the iOS platform.
    /// * URL - The default mobile browser on the recipient's device opens and loads
    ///   the web page at a URL that you specify.
    action: ?Action = null,

    /// The type of push notification to send. Valid values are:
    ///
    /// * alert - For a standard notification that's displayed on recipients'
    ///   devices and prompts a recipient to interact with the notification.
    /// * background - For a silent notification that delivers content in the
    ///   background and isn't displayed on recipients' devices.
    /// * complication - For a notification that contains update information for an
    ///   app’s complication timeline.
    /// * fileprovider - For a notification that signals changes to a File Provider
    ///   extension.
    /// * mdm - For a notification that tells managed devices to contact the MDM
    ///   server.
    /// * voip - For a notification that provides information about an incoming VoIP
    ///   call.
    ///
    /// Amazon Pinpoint specifies this value in the apns-push-type request header
    /// when it sends the notification message to APNs. If you don't specify a value
    /// for this property, Amazon Pinpoint sets the value to alert or background
    /// automatically, based on the value that you specify for the SilentPush or
    /// RawContent property of the message.
    ///
    /// For more information about the apns-push-type request header, see [Sending
    /// Notification Requests to
    /// APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns) on the Apple Developer website.
    apns_push_type: ?[]const u8 = null,

    /// The key that indicates whether and how to modify the badge of your app's
    /// icon when the recipient receives the push notification. If this key isn't
    /// included in the dictionary, the badge doesn't change. To remove the badge,
    /// set this value to 0.
    badge: ?i32 = null,

    /// The body of the notification message.
    body: ?[]const u8 = null,

    /// The key that indicates the notification type for the push notification. This
    /// key is a value that's defined by the identifier property of one of your
    /// app's registered categories.
    category: ?[]const u8 = null,

    /// An arbitrary identifier that, if assigned to multiple messages, APNs uses to
    /// coalesce the messages into a single push notification instead of delivering
    /// each message individually. This value can't exceed 64 bytes.
    ///
    /// Amazon Pinpoint specifies this value in the apns-collapse-id request header
    /// when it sends the notification message to APNs.
    collapse_id: ?[]const u8 = null,

    /// The JSON payload to use for a silent push notification. This payload is
    /// added to the data.pinpoint.jsonBody object of the notification.
    data: ?[]const aws.map.StringMapEntry = null,

    /// The URL of an image or video to display in the push notification.
    media_url: ?[]const u8 = null,

    /// The authentication method that you want Amazon Pinpoint to use when
    /// authenticating with APNs, CERTIFICATE or TOKEN.
    preferred_authentication_method: ?[]const u8 = null,

    /// para>5 - Low priority, the notification might be delayed, delivered as part
    /// of a group, or throttled./listitem>
    /// * 10 - High priority, the notification is sent immediately. This is the
    ///   default value. A high priority notification should trigger an alert, play
    ///   a sound, or badge your app's icon on the recipient's device./para>
    ///
    /// Amazon Pinpoint specifies this value in the apns-priority request header
    /// when it sends the notification message to APNs.
    ///
    /// The equivalent values for Firebase Cloud Messaging (FCM), formerly Google
    /// Cloud Messaging (GCM), are normal, for 5, and high, for 10. If you specify
    /// an FCM value for this property, Amazon Pinpoint accepts and converts the
    /// value to the corresponding APNs value.
    priority: ?[]const u8 = null,

    /// The raw, JSON-formatted string to use as the payload for the notification
    /// message. If specified, this value overrides all other content for the
    /// message.
    ///
    /// If you specify the raw content of an APNs push notification, the message
    /// payload has to include the content-available key. The value of the
    /// content-available key has to be an integer, and can only be 0 or 1. If
    /// you're sending a standard notification, set the value of content-available
    /// to 0. If you're sending a silent (background) notification, set the value of
    /// content-available to 1. Additionally, silent notification payloads can't
    /// include the alert, badge, or sound keys. For more information, see
    /// [Generating a Remote
    /// Notification](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification) and [Pushing Background Updates to Your App](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app) on the Apple Developer website.
    raw_content: ?[]const u8 = null,

    /// Specifies whether the notification is a silent push notification. A silent
    /// (or background) push notification isn't displayed on recipients' devices.
    /// You can use silent push notifications to make small updates to your app, or
    /// to display messages in an in-app message center.
    ///
    /// Amazon Pinpoint uses this property to determine the correct value for the
    /// apns-push-type request header when it sends the notification message to
    /// APNs. If you specify a value of true for this property, Amazon Pinpoint sets
    /// the value for the apns-push-type header field to background.
    ///
    /// If you specify the raw content of an APNs push notification, the message
    /// payload has to include the content-available key. For silent (background)
    /// notifications, set the value of content-available to 1. Additionally, the
    /// message payload for a silent notification can't include the alert, badge, or
    /// sound keys. For more information, see [Generating a Remote
    /// Notification](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification) and [Pushing Background Updates to Your App](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app) on the Apple Developer website.
    ///
    /// Apple has indicated that they will throttle "excessive" background
    /// notifications based on current traffic volumes. To prevent your
    /// notifications being throttled, Apple recommends that you send no more than 3
    /// silent push notifications to each recipient per hour.
    silent_push: ?bool = null,

    /// The key for the sound to play when the recipient receives the push
    /// notification. The value for this key is the name of a sound file in your
    /// app's main bundle or the Library/Sounds folder in your app's data container.
    /// If the sound file can't be found or you specify default for the value, the
    /// system plays the default alert sound.
    sound: ?[]const u8 = null,

    /// The default message variables to use in the notification message. You can
    /// override these default variables with individual address variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The key that represents your app-specific identifier for grouping
    /// notifications. If you provide a Notification Content app extension, you can
    /// use this value to group your notifications together.
    thread_id: ?[]const u8 = null,

    /// The amount of time, in seconds, that APNs should store and attempt to
    /// deliver the push notification, if the service is unable to deliver the
    /// notification the first time. If this value is 0, APNs treats the
    /// notification as if it expires immediately and the service doesn't store or
    /// try to deliver the notification again.
    ///
    /// Amazon Pinpoint specifies this value in the apns-expiration request header
    /// when it sends the notification message to APNs.
    time_to_live: ?i32 = null,

    /// The title to display above the notification message on the recipient's
    /// device.
    title: ?[]const u8 = null,

    /// The URL to open in the recipient's default mobile browser, if a recipient
    /// taps the push notification and the value of the Action property is URL.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .apns_push_type = "APNSPushType",
        .badge = "Badge",
        .body = "Body",
        .category = "Category",
        .collapse_id = "CollapseId",
        .data = "Data",
        .media_url = "MediaUrl",
        .preferred_authentication_method = "PreferredAuthenticationMethod",
        .priority = "Priority",
        .raw_content = "RawContent",
        .silent_push = "SilentPush",
        .sound = "Sound",
        .substitutions = "Substitutions",
        .thread_id = "ThreadId",
        .time_to_live = "TimeToLive",
        .title = "Title",
        .url = "Url",
    };
};
