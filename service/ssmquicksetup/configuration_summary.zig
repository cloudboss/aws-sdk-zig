const aws = @import("aws");

const StatusSummary = @import("status_summary.zig").StatusSummary;

/// Details for a Quick Setup configuration.
pub const ConfigurationSummary = struct {
    /// The ID of the Amazon Web Services account where the configuration was
    /// deployed.
    account: ?[]const u8,

    /// The ID of the configuration definition.
    configuration_definition_id: ?[]const u8,

    /// The datetime stamp when the configuration was created.
    created_at: ?i64,

    /// The common parameters and values for the configuration definition.
    first_class_parameters: ?[]const aws.map.StringMapEntry,

    /// A service generated identifier for the configuration.
    id: ?[]const u8,

    /// The ARN of the configuration manager.
    manager_arn: ?[]const u8,

    /// The Amazon Web Services Region where the configuration was deployed.
    region: ?[]const u8,

    /// A summary of the state of the configuration manager. This includes
    /// deployment
    /// statuses, association statuses, drift statuses, health checks, and more.
    status_summaries: ?[]const StatusSummary,

    /// The type of the Quick Setup configuration.
    @"type": ?[]const u8,

    /// The version of the Quick Setup type used.
    type_version: ?[]const u8,

    pub const json_field_names = .{
        .account = "Account",
        .configuration_definition_id = "ConfigurationDefinitionId",
        .created_at = "CreatedAt",
        .first_class_parameters = "FirstClassParameters",
        .id = "Id",
        .manager_arn = "ManagerArn",
        .region = "Region",
        .status_summaries = "StatusSummaries",
        .@"type" = "Type",
        .type_version = "TypeVersion",
    };
};
