/// The details of an environment profile.
pub const EnvironmentProfileSummary = struct {
    /// The identifier of an Amazon Web Services account in which an environment
    /// profile exists.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Web Services Region in which an environment profile exists.
    aws_account_region: ?[]const u8 = null,

    /// The timestamp of when an environment profile was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the environment profile.
    created_by: []const u8,

    /// The description of the environment profile.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the environment
    /// profile exists.
    domain_id: []const u8,

    /// The identifier of a blueprint with which an environment profile is created.
    environment_blueprint_id: []const u8,

    /// The identifier of the environment profile.
    id: []const u8,

    /// The name of the environment profile.
    name: []const u8,

    /// The identifier of a project in which an environment profile exists.
    project_id: ?[]const u8 = null,

    /// The timestamp of when the environment profile was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_region = "awsAccountRegion",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .environment_blueprint_id = "environmentBlueprintId",
        .id = "id",
        .name = "name",
        .project_id = "projectId",
        .updated_at = "updatedAt",
    };
};
