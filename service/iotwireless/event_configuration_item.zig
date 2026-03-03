const EventNotificationItemConfigurations = @import("event_notification_item_configurations.zig").EventNotificationItemConfigurations;
const IdentifierType = @import("identifier_type.zig").IdentifierType;
const EventNotificationPartnerType = @import("event_notification_partner_type.zig").EventNotificationPartnerType;

/// Event configuration object for a single resource.
pub const EventConfigurationItem = struct {
    events: ?EventNotificationItemConfigurations = null,

    /// Resource identifier opted in for event messaging.
    identifier: ?[]const u8 = null,

    /// Identifier type of the particular resource identifier for event
    /// configuration.
    identifier_type: ?IdentifierType = null,

    /// Partner type of the resource if the identifier type is PartnerAccountId.
    partner_type: ?EventNotificationPartnerType = null,

    pub const json_field_names = .{
        .events = "Events",
        .identifier = "Identifier",
        .identifier_type = "IdentifierType",
        .partner_type = "PartnerType",
    };
};
