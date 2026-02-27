const aws = @import("aws");

const Action = @import("action.zig").Action;

/// Specifies the settings for a one-time message that's sent directly to an
/// endpoint through the Baidu (Baidu Cloud Push) channel.
pub const BaiduMessage = struct {
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

    /// The raw, JSON-formatted string to use as the payload for the notification
    /// message. If specified, this value overrides all other content for the
    /// message.
    raw_content: ?[]const u8,

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

    /// The amount of time, in seconds, that the Baidu Cloud Push service should
    /// store the message if the recipient's device is offline. The default value
    /// and maximum supported time is 604,800 seconds (7 days).
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
        .data = "Data",
        .icon_reference = "IconReference",
        .image_icon_url = "ImageIconUrl",
        .image_url = "ImageUrl",
        .raw_content = "RawContent",
        .silent_push = "SilentPush",
        .small_image_icon_url = "SmallImageIconUrl",
        .sound = "Sound",
        .substitutions = "Substitutions",
        .time_to_live = "TimeToLive",
        .title = "Title",
        .url = "Url",
    };
};
