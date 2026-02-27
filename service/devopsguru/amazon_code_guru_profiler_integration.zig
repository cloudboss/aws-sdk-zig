const EventSourceOptInStatus = @import("event_source_opt_in_status.zig").EventSourceOptInStatus;

/// Information about your account's integration with Amazon CodeGuru Profiler.
/// This
/// returns whether DevOps Guru is configured to consume recommendations
/// generated from Amazon
/// CodeGuru Profiler.
pub const AmazonCodeGuruProfilerIntegration = struct {
    /// The status of the CodeGuru Profiler integration. Specifies if DevOps Guru is
    /// enabled to
    /// consume recommendations that are generated from Amazon CodeGuru Profiler.
    status: ?EventSourceOptInStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
