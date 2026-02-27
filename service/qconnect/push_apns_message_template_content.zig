const PushMessageAction = @import("push_message_action.zig").PushMessageAction;
const MessageTemplateBodyContentProvider = @import("message_template_body_content_provider.zig").MessageTemplateBodyContentProvider;

/// The content of the push message template that applies to APNS (Apple Push
/// Notification service) notification service.
pub const PushAPNSMessageTemplateContent = struct {
    /// The action to occur if a recipient taps a push notification that is based on
    /// the message template. Valid values are:
    ///
    /// * `OPEN_APP` - Your app opens or it becomes the foreground app if it was
    ///   sent to the background. This is the default action.
    /// * `DEEP_LINK` - Your app opens and displays a designated user interface in
    ///   the app. This action uses the deep-linking features of the iOS platform.
    /// * `URL` - The default mobile browser on the recipient's device opens and
    ///   loads the web page at a URL that you specify.
    action: ?PushMessageAction,

    /// The message body to use in a push notification that is based on the message
    /// template.
    body: ?MessageTemplateBodyContentProvider,

    /// The URL of an image or video to display in push notifications that are based
    /// on the message template.
    media_url: ?[]const u8,

    /// The raw, JSON-formatted string to use as the payload for a push notification
    /// that's based on the message template. If specified, this value overrides all
    /// other content for the message template.
    raw_content: ?MessageTemplateBodyContentProvider,

    /// The key for the sound to play when the recipient receives a push
    /// notification that's based on the message template. The value for this key is
    /// the name of a sound file in your app's main bundle or the `Library/Sounds`
    /// folder in your app's data container. If the sound file can't be found or you
    /// specify `default` for the value, the system plays the default alert sound.
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
        .media_url = "mediaUrl",
        .raw_content = "rawContent",
        .sound = "sound",
        .title = "title",
        .url = "url",
    };
};
