const ReadSetActivationJobStatus = @import("read_set_activation_job_status.zig").ReadSetActivationJobStatus;

/// A read set activation job filter.
pub const ActivateReadSetFilter = struct {
    /// The filter's start date.
    created_after: ?i64 = null,

    /// The filter's end date.
    created_before: ?i64 = null,

    /// The filter's status.
    status: ?ReadSetActivationJobStatus = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .status = "status",
    };
};
