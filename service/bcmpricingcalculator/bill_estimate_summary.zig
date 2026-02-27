const BillInterval = @import("bill_interval.zig").BillInterval;
const BillEstimateStatus = @import("bill_estimate_status.zig").BillEstimateStatus;

/// Provides a summary of a bill estimate.
pub const BillEstimateSummary = struct {
    /// The time period covered by the bill estimate.
    bill_interval: ?BillInterval,

    /// The timestamp when the bill estimate was created.
    created_at: ?i64,

    /// The timestamp when the bill estimate will expire.
    expires_at: ?i64,

    /// The unique identifier of the bill estimate.
    id: []const u8,

    /// The name of the bill estimate.
    name: ?[]const u8,

    /// The current status of the bill estimate.
    status: ?BillEstimateStatus,

    pub const json_field_names = .{
        .bill_interval = "billInterval",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
