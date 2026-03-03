const ActionType = @import("action_type.zig").ActionType;
const ImplementationEffort = @import("implementation_effort.zig").ImplementationEffort;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// Describes a filter that returns a more specific list of recommendations.
/// Filters recommendations by different dimensions.
pub const Filter = struct {
    /// The account to which the recommendation applies.
    account_ids: ?[]const []const u8 = null,

    /// The type of action you can take by adopting the recommendation.
    action_types: ?[]const ActionType = null,

    /// The effort required to implement the recommendation.
    implementation_efforts: ?[]const ImplementationEffort = null,

    /// The IDs for the recommendations.
    recommendation_ids: ?[]const []const u8 = null,

    /// The Amazon Web Services Region of the resource.
    regions: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the recommendation.
    resource_arns: ?[]const []const u8 = null,

    /// The resource ID of the recommendation.
    resource_ids: ?[]const []const u8 = null,

    /// The resource type of the recommendation.
    resource_types: ?[]const ResourceType = null,

    /// Whether or not implementing the recommendation requires a restart.
    restart_needed: ?bool = null,

    /// Whether or not implementing the recommendation can be rolled back.
    rollback_possible: ?bool = null,

    /// A list of tags assigned to the recommendation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .action_types = "actionTypes",
        .implementation_efforts = "implementationEfforts",
        .recommendation_ids = "recommendationIds",
        .regions = "regions",
        .resource_arns = "resourceArns",
        .resource_ids = "resourceIds",
        .resource_types = "resourceTypes",
        .restart_needed = "restartNeeded",
        .rollback_possible = "rollbackPossible",
        .tags = "tags",
    };
};
