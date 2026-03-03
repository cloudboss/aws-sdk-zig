const aws = @import("aws");

const AgentOrchestrationConfig = @import("agent_orchestration_config.zig").AgentOrchestrationConfig;
const ComputePlatform = @import("compute_platform.zig").ComputePlatform;
const ProfilingStatus = @import("profiling_status.zig").ProfilingStatus;

/// Contains information about a profiling group.
pub const ProfilingGroupDescription = struct {
    /// An [
    /// `AgentOrchestrationConfig`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_AgentOrchestrationConfig.html)
    /// object that indicates if the profiling group is enabled for profiled or not.
    agent_orchestration_config: ?AgentOrchestrationConfig = null,

    /// The Amazon Resource Name (ARN) identifying the profiling group resource.
    arn: ?[]const u8 = null,

    /// The compute platform of the profiling group. If it is set to `AWSLambda`,
    /// then
    /// the profiled application runs on AWS Lambda. If it is set to `Default`, then
    /// the
    /// profiled application runs on a compute platform that is not AWS Lambda, such
    /// an Amazon EC2 instance,
    /// an on-premises server, or a different platform. The default is `Default`.
    compute_platform: ?ComputePlatform = null,

    /// The time when the profiling group was created. Specify using
    /// the ISO 8601 format. For example,
    /// 2020-06-01T13:15:02.001Z represents 1 millisecond past June 1, 2020 1:15:02
    /// PM UTC.
    created_at: ?i64 = null,

    /// The name of the profiling group.
    name: ?[]const u8 = null,

    /// A [
    /// `ProfilingStatus`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingStatus.html) object
    /// that includes information about the last time a profile agent pinged back,
    /// the last time a profile was received, and the aggregation period and start
    /// time for the
    /// most recent aggregated profile.
    profiling_status: ?ProfilingStatus = null,

    /// A list of the tags that belong to this profiling group.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time when the profiling group was last updated. Specify using
    /// the ISO 8601 format. For example,
    /// 2020-06-01T13:15:02.001Z represents 1 millisecond past June 1, 2020 1:15:02
    /// PM UTC.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_orchestration_config = "agentOrchestrationConfig",
        .arn = "arn",
        .compute_platform = "computePlatform",
        .created_at = "createdAt",
        .name = "name",
        .profiling_status = "profilingStatus",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
