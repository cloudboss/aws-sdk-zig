const DeliveryEventType = @import("delivery_event_type.zig").DeliveryEventType;
const EngagementEventType = @import("engagement_event_type.zig").EngagementEventType;

/// An object containing Message Insights filters.
///
/// If you specify multiple filters, the filters are joined by AND.
///
/// If you specify multiple values for a filter, the values are joined by OR.
/// Filter values are case-sensitive.
///
/// `FromEmailAddress`, `Destination`, and `Subject` filters support partial
/// match.
/// A partial match is performed by using the `*` wildcard character placed at
/// the beginning (suffix match), the end (prefix match)
/// or both ends of the string (contains match).
/// In order to match the literal characters `*` or `\`, they must be escaped
/// using the `\` character.
/// If no wildcard character is present, an exact match is performed.
pub const MessageInsightsFilters = struct {
    /// The recipient's email address.
    destination: ?[]const []const u8 = null,

    /// The from address used to send the message.
    from_email_address: ?[]const []const u8 = null,

    /// The recipient's ISP (e.g., `Gmail`, `Yahoo`,
    /// etc.).
    isp: ?[]const []const u8 = null,

    /// The last delivery-related event for the email, where the ordering is as
    /// follows:
    /// `SEND` < `BOUNCE` < `DELIVERY` < `COMPLAINT`.
    last_delivery_event: ?[]const DeliveryEventType = null,

    /// The last engagement-related event for the email, where the ordering is as
    /// follows:
    /// `OPEN` < `CLICK`.
    ///
    /// Engagement events are only available if [Engagement
    /// tracking](https://docs.aws.amazon.com/ses/latest/dg/vdm-settings.html)
    /// is enabled.
    last_engagement_event: ?[]const EngagementEventType = null,

    /// The subject line of the message.
    subject: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .from_email_address = "FromEmailAddress",
        .isp = "Isp",
        .last_delivery_event = "LastDeliveryEvent",
        .last_engagement_event = "LastEngagementEvent",
        .subject = "Subject",
    };
};
