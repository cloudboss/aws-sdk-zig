const aws = @import("aws");

const ResourceUtilization = @import("resource_utilization.zig").ResourceUtilization;
const SessionConfigurationOverrides = @import("session_configuration_overrides.zig").SessionConfigurationOverrides;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const SessionState = @import("session_state.zig").SessionState;
const TotalResourceUtilization = @import("total_resource_utilization.zig").TotalResourceUtilization;

/// Information about a session, including the session state, configuration, and
/// timestamps.
pub const Session = struct {
    /// The ID of the application that the session belongs to.
    application_id: []const u8,

    /// The Amazon Resource Name (ARN) of the session.
    arn: []const u8,

    /// The aggregate vCPU, memory, and storage that Amazon Web Services has billed
    /// for the session. The billed resources include a 1-minute minimum usage for
    /// workers, plus additional storage over 20 GB per worker. Note that billed
    /// resources do not include usage for idle pre-initialized workers.
    billed_resource_utilization: ?ResourceUtilization = null,

    /// The configuration overrides for the session, including runtime configuration
    /// properties.
    configuration_overrides: ?SessionConfigurationOverrides = null,

    /// The date and time that the session was created.
    created_at: i64,

    /// The IAM principal that created the session.
    created_by: []const u8,

    /// The date and time that the session was terminated or failed.
    ended_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the execution role for the session.
    execution_role_arn: []const u8,

    /// The date and time that the session became idle.
    idle_since: ?i64 = null,

    /// The idle timeout in minutes for the session. After the session remains idle
    /// for this duration, it is automatically terminated.
    idle_timeout_minutes: ?i64 = null,

    /// The optional name of the session.
    name: ?[]const u8 = null,

    /// The network configuration for customer VPC connectivity for the session.
    network_configuration: ?NetworkConfiguration = null,

    /// The Amazon EMR release label associated with the session.
    release_label: []const u8,

    /// The ID of the session.
    session_id: []const u8,

    /// The date and time that the session moved to a running state.
    started_at: ?i64 = null,

    /// The state of the session.
    state: SessionState,

    /// Additional details about the current state of the session.
    state_details: []const u8,

    /// The tags assigned to the session.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The total execution duration of the session in seconds.
    total_execution_duration_seconds: ?i64 = null,

    /// The aggregate vCPU, memory, and storage resources used from the time the
    /// session starts to execute, until the time the session terminates, rounded up
    /// to the nearest second.
    total_resource_utilization: ?TotalResourceUtilization = null,

    /// The date and time that the session was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .billed_resource_utilization = "billedResourceUtilization",
        .configuration_overrides = "configurationOverrides",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .execution_role_arn = "executionRoleArn",
        .idle_since = "idleSince",
        .idle_timeout_minutes = "idleTimeoutMinutes",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .release_label = "releaseLabel",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .state = "state",
        .state_details = "stateDetails",
        .tags = "tags",
        .total_execution_duration_seconds = "totalExecutionDurationSeconds",
        .total_resource_utilization = "totalResourceUtilization",
        .updated_at = "updatedAt",
    };
};
