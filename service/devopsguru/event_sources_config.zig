const AmazonCodeGuruProfilerIntegration = @import("amazon_code_guru_profiler_integration.zig").AmazonCodeGuruProfilerIntegration;

/// Information about the integration of DevOps Guru as consumer with another
/// AWS service, such
/// as AWS CodeGuru Profiler via EventBridge.
pub const EventSourcesConfig = struct {
    /// Information about whether DevOps Guru is configured to consume
    /// recommendations which
    /// are generated from AWS CodeGuru Profiler.
    amazon_code_guru_profiler: ?AmazonCodeGuruProfilerIntegration,

    pub const json_field_names = .{
        .amazon_code_guru_profiler = "AmazonCodeGuruProfiler",
    };
};
