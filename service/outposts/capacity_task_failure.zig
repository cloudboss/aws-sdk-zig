const CapacityTaskFailureType = @import("capacity_task_failure_type.zig").CapacityTaskFailureType;

/// The capacity tasks that failed.
pub const CapacityTaskFailure = struct {
    /// The reason that the specified capacity task failed.
    reason: []const u8,

    /// The type of failure.
    @"type": ?CapacityTaskFailureType,

    pub const json_field_names = .{
        .reason = "Reason",
        .@"type" = "Type",
    };
};
