const aws = @import("aws");

const Action = @import("action.zig").Action;

/// Specifies the default settings and content for a push notification that's
/// sent directly to an endpoint.
pub const DefaultPushNotificationMessage = struct {
    /// The default action to occur if a recipient taps the push notification. Valid
    /// values are:
    ///
    /// * OPEN_APP - Your app opens or it becomes the foreground app if it was sent
    ///   to the background. This is the default action.
    /// * DEEP_LINK - Your app opens and displays a designated user interface in the
    ///   app. This setting uses the deep-linking features of the iOS and Android
    ///   platforms.
    /// * URL - The default mobile browser on the recipient's device opens and loads
    ///   the web page at a URL that you specify.
    action: ?Action,

    /// The default body of the notification message.
    body: ?[]const u8,

    /// The JSON data payload to use for the default push notification, if the
    /// notification is a silent push notification. This payload is added to the
    /// data.pinpoint.jsonBody object of the notification.
    data: ?[]const aws.map.StringMapEntry,

    /// Specifies whether the default notification is a silent push notification,
    /// which is a push notification that doesn't display on a recipient's device.
    /// Silent push notifications can be used for cases such as updating an app's
    /// configuration or delivering messages to an in-app notification center.
    silent_push: ?bool,

    /// The default message variables to use in the notification message. You can
    /// override the default variables with individual address variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8),

    /// The default title to display above the notification message on a recipient's
    /// device.
    title: ?[]const u8,

    /// The default URL to open in a recipient's default mobile browser, if a
    /// recipient taps the push notification and the value of the Action property is
    /// URL.
    url: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .body = "Body",
        .data = "Data",
        .silent_push = "SilentPush",
        .substitutions = "Substitutions",
        .title = "Title",
        .url = "Url",
    };
};
