const BilledResourceUtilization = @import("billed_resource_utilization.zig").BilledResourceUtilization;

/// Contains statistics about the execution of the protected query.
pub const ProtectedQueryStatistics = struct {
    /// The billed resource utilization.
    billed_resource_utilization: ?BilledResourceUtilization,

    /// The duration of the protected query, from creation until query completion,
    /// in milliseconds.
    total_duration_in_millis: ?i64,

    pub const json_field_names = .{
        .billed_resource_utilization = "billedResourceUtilization",
        .total_duration_in_millis = "totalDurationInMillis",
    };
};
