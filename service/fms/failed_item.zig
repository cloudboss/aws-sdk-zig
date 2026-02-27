const FailedItemReason = @import("failed_item_reason.zig").FailedItemReason;

/// Details of a resource that failed when trying to update it's association to
/// a resource set.
pub const FailedItem = struct {
    /// The reason the resource's association could not be updated.
    reason: ?FailedItemReason,

    /// The univeral resource indicator (URI) of the resource that failed.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .reason = "Reason",
        .uri = "URI",
    };
};
