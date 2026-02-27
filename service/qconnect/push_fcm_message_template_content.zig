const PushMessageAction = @import("push_message_action.zig").PushMessageAction;
const MessageTemplateBodyContentProvider = @import("message_template_body_content_provider.zig").MessageTemplateBodyContentProvider;

/// The content of the push message template that applies to FCM (Firebase Cloud
/// Messaging) notification service.
pub const PushFCMMessageTemplateContent = struct {
    /// The action to occur if a recipient taps a push notification that is based on
    /// the message template. Valid values are:
    ///
    /// * `OPEN_APP` - Your app opens or it becomes the foreground app if it was
    ///   sent to the background. This is the default action.
    /// * `DEEP_LINK` - Your app opens and displays a designated user interface in
    ///   the app. This action uses the deep-linking features of the Android
    ///   platform.
    /// * `URL` - The default mobile browser on the recipient's device opens and
    ///   loads the web page at a URL that you specify.
    action: ?PushMessageAction,

    /// The message body to use in a push notification that is based on the message
    /// template.
    body: ?MessageTemplateBodyContentProvider,

    /// The URL of the large icon image to display in the content view of a push
    /// notification that's based on the message template.
    image_icon_url: ?[]const u8,

    /// The URL of an image to display in a push notification that's based on the
    /// message template.
    image_url: ?[]const u8,

    /// The URL of the small icon image to display in the status bar and the content
    /// view of a push notification that's based on the message template.
    raw_content: ?MessageTemplateBodyContentProvider,

    /// The URL of the small icon image to display in the status bar and the content
    /// view of a push notification that's based on the message template.
    small_image_icon_url: ?[]const u8,

    /// The sound to play when a recipient receives a push notification that's based
    /// on the message template. You can use the default stream or specify the file
    /// name of a sound resource that's bundled in your app. On an Android platform,
    /// the sound file must reside in `/res/raw/`.
    sound: ?[]const u8,

    /// The title to use in a push notification that's based on the message
    /// template. This title appears above the notification message on a recipient's
    /// device.
    title: ?[]const u8,

    /// The URL to open in a recipient's default mobile browser, if a recipient taps
    /// a push notification that's based on the message template and the value of
    /// the `action` property is `URL`.
    url: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .body = "body",
        .image_icon_url = "imageIconUrl",
        .image_url = "imageUrl",
        .raw_content = "rawContent",
        .small_image_icon_url = "smallImageIconUrl",
        .sound = "sound",
        .title = "title",
        .url = "url",
    };
};
