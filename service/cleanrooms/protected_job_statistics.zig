const BilledJobResourceUtilization = @import("billed_job_resource_utilization.zig").BilledJobResourceUtilization;

/// Contains statistics about the execution of the protected job.
pub const ProtectedJobStatistics = struct {
    /// The billed resource utilization for the protected job.
    billed_resource_utilization: ?BilledJobResourceUtilization,

    /// The duration of the protected job, from creation until job completion, in
    /// milliseconds.
    total_duration_in_millis: ?i64,

    pub const json_field_names = .{
        .billed_resource_utilization = "billedResourceUtilization",
        .total_duration_in_millis = "totalDurationInMillis",
    };
};
