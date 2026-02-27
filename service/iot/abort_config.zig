const AbortCriteria = @import("abort_criteria.zig").AbortCriteria;

/// The criteria that determine when and how a job abort takes place.
pub const AbortConfig = struct {
    /// The list of criteria that determine when and how to abort the job.
    criteria_list: []const AbortCriteria,

    pub const json_field_names = .{
        .criteria_list = "criteriaList",
    };
};
