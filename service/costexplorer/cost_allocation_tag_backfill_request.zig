const CostAllocationTagBackfillStatus = @import("cost_allocation_tag_backfill_status.zig").CostAllocationTagBackfillStatus;

/// The cost allocation tag backfill request structure that contains metadata
/// and details of a certain backfill.
pub const CostAllocationTagBackfillRequest = struct {
    /// The date the backfill starts from.
    backfill_from: ?[]const u8,

    /// The status of the cost allocation tag backfill request.
    backfill_status: ?CostAllocationTagBackfillStatus,

    /// The backfill completion time.
    completed_at: ?[]const u8,

    /// The time when the backfill status was last updated.
    last_updated_at: ?[]const u8,

    /// The time when the backfill was requested.
    requested_at: ?[]const u8,

    pub const json_field_names = .{
        .backfill_from = "BackfillFrom",
        .backfill_status = "BackfillStatus",
        .completed_at = "CompletedAt",
        .last_updated_at = "LastUpdatedAt",
        .requested_at = "RequestedAt",
    };
};
