const ConfigurationDefinitionSummary = @import("configuration_definition_summary.zig").ConfigurationDefinitionSummary;
const StatusSummary = @import("status_summary.zig").StatusSummary;

/// A summary of a Quick Setup configuration manager.
pub const ConfigurationManagerSummary = struct {
    /// A summary of the Quick Setup configuration definition.
    configuration_definition_summaries: ?[]const ConfigurationDefinitionSummary = null,

    /// The description of the configuration.
    description: ?[]const u8 = null,

    /// The ARN of the Quick Setup configuration.
    manager_arn: []const u8,

    /// The name of the configuration
    name: ?[]const u8 = null,

    /// Summaries of the state of the configuration manager. These summaries include
    /// an
    /// aggregate of the statuses from the configuration definition associated with
    /// the
    /// configuration manager. This includes deployment statuses, association
    /// statuses,
    /// drift statuses, health checks, and more.
    status_summaries: ?[]const StatusSummary = null,

    pub const json_field_names = .{
        .configuration_definition_summaries = "ConfigurationDefinitionSummaries",
        .description = "Description",
        .manager_arn = "ManagerArn",
        .name = "Name",
        .status_summaries = "StatusSummaries",
    };
};
