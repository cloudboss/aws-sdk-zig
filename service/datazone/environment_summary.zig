const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;

/// The details of an environment.
pub const EnvironmentSummary = struct {
    /// The identifier of the Amazon Web Services account in which an environment
    /// exists.
    aws_account_id: ?[]const u8,

    /// The Amazon Web Services Region in which an environment exists.
    aws_account_region: ?[]const u8,

    /// The timestamp of when the environment was created.
    created_at: ?i64,

    /// The Amazon DataZone user who created the environment.
    created_by: []const u8,

    /// The description of the environment.
    description: ?[]const u8,

    /// The identifier of the Amazon DataZone domain in which the environment
    /// exists.
    domain_id: []const u8,

    /// The configuration ID with which the environment is created.
    environment_configuration_id: ?[]const u8,

    /// The identifier of the environment profile with which the environment was
    /// created.
    environment_profile_id: []const u8 = "",

    /// The identifier of the environment.
    id: ?[]const u8,

    /// The name of the environment.
    name: []const u8,

    /// The identifier of the project in which the environment exists.
    project_id: []const u8,

    /// The provider of the environment.
    provider: []const u8,

    /// The status of the environment.
    status: ?EnvironmentStatus,

    /// The timestamp of when the environment was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_region = "awsAccountRegion",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .environment_configuration_id = "environmentConfigurationId",
        .environment_profile_id = "environmentProfileId",
        .id = "id",
        .name = "name",
        .project_id = "projectId",
        .provider = "provider",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
