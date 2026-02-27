const Ide = @import("ide.zig").Ide;
const InstanceType = @import("instance_type.zig").InstanceType;
const PersistentStorage = @import("persistent_storage.zig").PersistentStorage;
const DevEnvironmentRepositorySummary = @import("dev_environment_repository_summary.zig").DevEnvironmentRepositorySummary;
const DevEnvironmentStatus = @import("dev_environment_status.zig").DevEnvironmentStatus;

/// Information about a Dev Environment.
pub const DevEnvironmentSummary = struct {
    /// The user-specified alias for the Dev Environment.
    alias: ?[]const u8,

    /// The system-generated unique ID of the user who created the Dev Environment.
    creator_id: []const u8,

    /// The system-generated unique ID for the Dev Environment.
    id: []const u8,

    /// Information about the integrated development environment (IDE) configured
    /// for a Dev Environment.
    ides: ?[]const Ide,

    /// The amount of time the Dev Environment will run without any activity
    /// detected before stopping, in minutes. Dev Environments consume compute
    /// minutes when running.
    inactivity_timeout_minutes: i32 = 0,

    /// The Amazon EC2 instace type used for the Dev Environment.
    instance_type: InstanceType,

    /// The time when the Dev Environment was last updated, in coordinated universal
    /// time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    last_updated_time: i64,

    /// Information about the configuration of persistent storage for the Dev
    /// Environment.
    persistent_storage: PersistentStorage,

    /// The name of the project in the space.
    project_name: ?[]const u8,

    /// Information about the repositories that will be cloned into the Dev
    /// Environment. If no rvalue is specified, no repository is cloned.
    repositories: []const DevEnvironmentRepositorySummary,

    /// The name of the space.
    space_name: ?[]const u8,

    /// The status of the Dev Environment.
    status: DevEnvironmentStatus,

    /// The reason for the status.
    status_reason: ?[]const u8,

    /// The name of the connection used to connect to Amazon VPC used when the Dev
    /// Environment was created, if any.
    vpc_connection_name: ?[]const u8,

    pub const json_field_names = .{
        .alias = "alias",
        .creator_id = "creatorId",
        .id = "id",
        .ides = "ides",
        .inactivity_timeout_minutes = "inactivityTimeoutMinutes",
        .instance_type = "instanceType",
        .last_updated_time = "lastUpdatedTime",
        .persistent_storage = "persistentStorage",
        .project_name = "projectName",
        .repositories = "repositories",
        .space_name = "spaceName",
        .status = "status",
        .status_reason = "statusReason",
        .vpc_connection_name = "vpcConnectionName",
    };
};
