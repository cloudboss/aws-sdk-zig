const IoTJobAbortCriteria = @import("io_t_job_abort_criteria.zig").IoTJobAbortCriteria;

/// Contains a list of criteria that define when and how to cancel a
/// configuration
/// deployment.
pub const IoTJobAbortConfig = struct {
    /// The list of criteria that define when and how to cancel the configuration
    /// deployment.
    criteria_list: []const IoTJobAbortCriteria,

    pub const json_field_names = .{
        .criteria_list = "criteriaList",
    };
};
