const aws = @import("aws");

const Action = @import("action.zig").Action;

/// Specifies the settings for a one-time message that's sent directly to an
/// endpoint through the GCM channel. The GCM channel enables Amazon Pinpoint to
/// send messages to the Firebase Cloud Messaging (FCM), formerly Google Cloud
/// Messaging (GCM), service.
pub const GCMMessage = struct {
    /// The action to occur if the recipient taps the push notification. Valid
    /// values are:
    ///
    /// * OPEN_APP - Your app opens or it becomes the foreground app if it was sent
    ///   to the background. This is the default action.
    /// * DEEP_LINK - Your app opens and displays a designated user interface in the
    ///   app. This action uses the deep-linking features of the Android platform.
    /// * URL - The default mobile browser on the recipient's device opens and loads
    ///   the web page at a URL that you specify.
    action: ?Action,

    /// The body of the notification message.
    body: ?[]const u8,

    /// An arbitrary string that identifies a group of messages that can be
    /// collapsed to ensure that only the last message is sent when delivery can
    /// resume. This helps avoid sending too many instances of the same messages
    /// when the recipient's device comes online again or becomes active.
    ///
    /// Amazon Pinpoint specifies this value in the Firebase Cloud Messaging (FCM)
    /// collapse_key parameter when it sends the notification message to FCM.
    collapse_key: ?[]const u8,

    /// The JSON data payload to use for the push notification, if the notification
    /// is a silent push notification. This payload is added to the
    /// data.pinpoint.jsonBody object of the notification.
    data: ?[]const aws.map.StringMapEntry,

    /// The icon image name of the asset saved in your app.
    icon_reference: ?[]const u8,

    /// The URL of the large icon image to display in the content view of the push
    /// notification.
    image_icon_url: ?[]const u8,

    /// The URL of an image to display in the push notification.
    image_url: ?[]const u8,

    /// The preferred authentication method, with valid values "KEY" or "TOKEN". If
    /// a value isn't provided then the **DefaultAuthenticationMethod** is used.
    preferred_authentication_method: ?[]const u8,

    /// para>normal – The notification might be delayed. Delivery is optimized for
    /// battery usage on the recipient's device. Use this value unless immediate
    /// delivery is required./listitem>
    /// * high – The notification is sent immediately and might wake a sleeping
    ///   device./para>
    ///
    /// Amazon Pinpoint specifies this value in the FCM priority parameter when it
    /// sends the notification message to FCM.
    ///
    /// The equivalent values for Apple Push Notification service (APNs) are 5, for
    /// normal, and 10, for high. If you specify an APNs value for this property,
    /// Amazon Pinpoint accepts and converts the value to the corresponding FCM
    /// value.
    priority: ?[]const u8,

    /// The raw, JSON-formatted string to use as the payload for the notification
    /// message. If specified, this value overrides all other content for the
    /// message.
    raw_content: ?[]const u8,

    /// The package name of the application where registration tokens must match in
    /// order for the recipient to receive the message.
    restricted_package_name: ?[]const u8,

    /// Specifies whether the notification is a silent push notification, which is a
    /// push notification that doesn't display on a recipient's device. Silent push
    /// notifications can be used for cases such as updating an app's configuration
    /// or supporting phone home functionality.
    silent_push: ?bool,

    /// The URL of the small icon image to display in the status bar and the content
    /// view of the push notification.
    small_image_icon_url: ?[]const u8,

    /// The sound to play when the recipient receives the push notification. You can
    /// use the default stream or specify the file name of a sound resource that's
    /// bundled in your app. On an Android platform, the sound file must reside in
    /// /res/raw/.
    sound: ?[]const u8,

    /// The default message variables to use in the notification message. You can
    /// override the default variables with individual address variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8),

    /// The amount of time, in seconds, that FCM should store and attempt to deliver
    /// the push notification, if the service is unable to deliver the notification
    /// the first time. If you don't specify this value, FCM defaults to the maximum
    /// value, which is 2,419,200 seconds (28 days).
    ///
    /// Amazon Pinpoint specifies this value in the FCM time_to_live parameter when
    /// it sends the notification message to FCM.
    time_to_live: ?i32,

    /// The title to display above the notification message on the recipient's
    /// device.
    title: ?[]const u8,

    /// The URL to open in the recipient's default mobile browser, if a recipient
    /// taps the push notification and the value of the Action property is URL.
    url: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .body = "Body",
        .collapse_key = "CollapseKey",
        .data = "Data",
        .icon_reference = "IconReference",
        .image_icon_url = "ImageIconUrl",
        .image_url = "ImageUrl",
        .preferred_authentication_method = "PreferredAuthenticationMethod",
        .priority = "Priority",
        .raw_content = "RawContent",
        .restricted_package_name = "RestrictedPackageName",
        .silent_push = "SilentPush",
        .small_image_icon_url = "SmallImageIconUrl",
        .sound = "Sound",
        .substitutions = "Substitutions",
        .time_to_live = "TimeToLive",
        .title = "Title",
        .url = "Url",
    };
};
