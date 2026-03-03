const Action = @import("action.zig").Action;

/// Specifies channel-specific content and settings for a message template that
/// can be used in push notifications that are sent through the ADM (Amazon
/// Device Messaging), Baidu (Baidu Cloud Push), or GCM (Firebase Cloud
/// Messaging, formerly Google Cloud Messaging) channel.
pub const AndroidPushNotificationTemplate = struct {
    /// The action to occur if a recipient taps a push notification that's based on
    /// the message template. Valid values are:
    ///
    /// * OPEN_APP - Your app opens or it becomes the foreground app if it was sent
    ///   to the background. This is the default action.
    /// * DEEP_LINK - Your app opens and displays a designated user interface in the
    ///   app. This action uses the deep-linking features of the Android platform.
    /// * URL - The default mobile browser on the recipient's device opens and loads
    ///   the web page at a URL that you specify.
    action: ?Action = null,

    /// The message body to use in a push notification that's based on the message
    /// template.
    body: ?[]const u8 = null,

    /// The URL of the large icon image to display in the content view of a push
    /// notification that's based on the message template.
    image_icon_url: ?[]const u8 = null,

    /// The URL of an image to display in a push notification that's based on the
    /// message template.
    image_url: ?[]const u8 = null,

    /// The raw, JSON-formatted string to use as the payload for a push notification
    /// that's based on the message template. If specified, this value overrides all
    /// other content for the message template.
    raw_content: ?[]const u8 = null,

    /// The URL of the small icon image to display in the status bar and the content
    /// view of a push notification that's based on the message template.
    small_image_icon_url: ?[]const u8 = null,

    /// The sound to play when a recipient receives a push notification that's based
    /// on the message template. You can use the default stream or specify the file
    /// name of a sound resource that's bundled in your app. On an Android platform,
    /// the sound file must reside in /res/raw/.
    sound: ?[]const u8 = null,

    /// The title to use in a push notification that's based on the message
    /// template. This title appears above the notification message on a recipient's
    /// device.
    title: ?[]const u8 = null,

    /// The URL to open in a recipient's default mobile browser, if a recipient taps
    /// a push notification that's based on the message template and the value of
    /// the Action property is URL.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .body = "Body",
        .image_icon_url = "ImageIconUrl",
        .image_url = "ImageUrl",
        .raw_content = "RawContent",
        .small_image_icon_url = "SmallImageIconUrl",
        .sound = "Sound",
        .title = "Title",
        .url = "Url",
    };
};
