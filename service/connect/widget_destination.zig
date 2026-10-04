/// The destination for an outbound web notification, specifying the
/// communication widget that delivers the
/// notification and the customer profile of the recipient.
pub const WidgetDestination = struct {
    /// The identifier of the customer profile associated with the browser session
    /// that should receive the
    /// notification.
    profile_id: []const u8,

    /// The identifier of the communication widget that delivers the notification to
    /// the customer's browser.
    widget_id: []const u8,

    pub const json_field_names = .{
        .profile_id = "ProfileId",
        .widget_id = "WidgetId",
    };
};
