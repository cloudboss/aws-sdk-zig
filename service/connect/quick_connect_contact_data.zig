const QuickConnectType = @import("quick_connect_type.zig").QuickConnectType;

/// Contact data associated with quick connect operations.
pub const QuickConnectContactData = struct {
    /// The contact ID for quick connect contact data.
    contact_id: ?[]const u8,

    /// Timestamp when the quick connect contact was initiated.
    initiation_timestamp: ?i64,

    /// The quick connect ID.
    quick_connect_id: ?[]const u8,

    /// The name of the quick connect.
    quick_connect_name: ?[]const u8,

    /// The type of the quick connect.
    quick_connect_type: ?QuickConnectType,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .initiation_timestamp = "InitiationTimestamp",
        .quick_connect_id = "QuickConnectId",
        .quick_connect_name = "QuickConnectName",
        .quick_connect_type = "QuickConnectType",
    };
};
