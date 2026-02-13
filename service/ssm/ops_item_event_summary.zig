const OpsItemIdentity = @import("ops_item_identity.zig").OpsItemIdentity;

/// Summary information about an OpsItem event or that associated an OpsItem
/// with a related
/// item.
pub const OpsItemEventSummary = struct {
    /// Information about the user or resource that created the OpsItem event.
    created_by: ?OpsItemIdentity,

    /// The date and time the OpsItem event was created.
    created_time: ?i64,

    /// Specific information about the OpsItem event.
    detail: ?[]const u8,

    /// The type of information provided as a detail.
    detail_type: ?[]const u8,

    /// The ID of the OpsItem event.
    event_id: ?[]const u8,

    /// The ID of the OpsItem.
    ops_item_id: ?[]const u8,

    /// The source of the OpsItem event.
    source: ?[]const u8,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .detail = "Detail",
        .detail_type = "DetailType",
        .event_id = "EventId",
        .ops_item_id = "OpsItemId",
        .source = "Source",
    };
};
