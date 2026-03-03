const WhatsAppBusinessAccountEventDestination = @import("whats_app_business_account_event_destination.zig").WhatsAppBusinessAccountEventDestination;
const Tag = @import("tag.zig").Tag;

/// The registration details for a linked WhatsApp Business Account.
pub const WabaSetupFinalization = struct {
    /// The event destinations for the linked WhatsApp Business Account.
    event_destinations: ?[]const WhatsAppBusinessAccountEventDestination = null,

    /// The ID of the linked WhatsApp Business Account, formatted as
    /// `waba-01234567890123456789012345678901`.
    id: ?[]const u8 = null,

    /// An array of key and value pair tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .event_destinations = "eventDestinations",
        .id = "id",
        .tags = "tags",
    };
};
