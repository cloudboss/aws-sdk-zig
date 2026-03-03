const CapacityAllocationStatus = @import("capacity_allocation_status.zig").CapacityAllocationStatus;

/// Contains the submission time of a single allocation request for a capacity
/// reservation
/// and the most recent status of the attempted allocation.
pub const CapacityAllocation = struct {
    /// The time when the capacity allocation request was completed.
    request_completion_time: ?i64 = null,

    /// The time when the capacity allocation was requested.
    request_time: i64,

    /// The status of the capacity allocation.
    status: CapacityAllocationStatus,

    /// The status message of the capacity allocation.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .request_completion_time = "RequestCompletionTime",
        .request_time = "RequestTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
