const Action = @import("action.zig").Action;

/// Specifies the default settings and content for a message template that can
/// be used in messages that are sent through a push notification channel.
pub const DefaultPushNotificationTemplate = struct {
    /// The action to occur if a recipient taps a push notification that's based on
    /// the message template. Valid values are:
    ///
    /// * OPEN_APP - Your app opens or it becomes the foreground app if it was sent
    ///   to the background. This is the default action.
    /// * DEEP_LINK - Your app opens and displays a designated user interface in the
    ///   app. This setting uses the deep-linking features of the iOS and Android
    ///   platforms.
    /// * URL - The default mobile browser on the recipient's device opens and loads
    ///   the web page at a URL that you specify.
    action: ?Action = null,

    /// The message body to use in push notifications that are based on the message
    /// template.
    body: ?[]const u8 = null,

    /// The sound to play when a recipient receives a push notification that's based
    /// on the message template. You can use the default stream or specify the file
    /// name of a sound resource that's bundled in your app. On an Android platform,
    /// the sound file must reside in /res/raw/.
    ///
    /// For an iOS platform, this value is the key for the name of a sound file in
    /// your app's main bundle or the Library/Sounds folder in your app's data
    /// container. If the sound file can't be found or you specify default for the
    /// value, the system plays the default alert sound.
    sound: ?[]const u8 = null,

    /// The title to use in push notifications that are based on the message
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
        .sound = "Sound",
        .title = "Title",
        .url = "Url",
    };
};
