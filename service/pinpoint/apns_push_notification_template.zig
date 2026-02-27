const Action = @import("action.zig").Action;

/// Specifies channel-specific content and settings for a message template that
/// can be used in push notifications that are sent through the APNs (Apple Push
/// Notification service) channel.
pub const APNSPushNotificationTemplate = struct {
    /// The action to occur if a recipient taps a push notification that's based on
    /// the message template. Valid values are:
    ///
    /// * OPEN_APP - Your app opens or it becomes the foreground app if it was sent
    ///   to the background. This is the default action.
    /// * DEEP_LINK - Your app opens and displays a designated user interface in the
    ///   app. This setting uses the deep-linking features of the iOS platform.
    /// * URL - The default mobile browser on the recipient's device opens and loads
    ///   the web page at a URL that you specify.
    action: ?Action,

    /// The message body to use in push notifications that are based on the message
    /// template.
    body: ?[]const u8,

    /// The URL of an image or video to display in push notifications that are based
    /// on the message template.
    media_url: ?[]const u8,

    /// The raw, JSON-formatted string to use as the payload for push notifications
    /// that are based on the message template. If specified, this value overrides
    /// all other content for the message template.
    raw_content: ?[]const u8,

    /// The key for the sound to play when the recipient receives a push
    /// notification that's based on the message template. The value for this key is
    /// the name of a sound file in your app's main bundle or the Library/Sounds
    /// folder in your app's data container. If the sound file can't be found or you
    /// specify default for the value, the system plays the default alert sound.
    sound: ?[]const u8,

    /// The title to use in push notifications that are based on the message
    /// template. This title appears above the notification message on a recipient's
    /// device.
    title: ?[]const u8,

    /// The URL to open in the recipient's default mobile browser, if a recipient
    /// taps a push notification that's based on the message template and the value
    /// of the Action property is URL.
    url: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .body = "Body",
        .media_url = "MediaUrl",
        .raw_content = "RawContent",
        .sound = "Sound",
        .title = "Title",
        .url = "Url",
    };
};
