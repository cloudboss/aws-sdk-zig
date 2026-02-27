const aws = @import("aws");

const FilterAction = @import("filter_action.zig").FilterAction;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;

/// Details about a filter.
pub const Filter = struct {
    /// The action that is to be applied to the findings that match the filter.
    action: FilterAction,

    /// The Amazon Resource Number (ARN) associated with this filter.
    arn: []const u8,

    /// The date and time this filter was created at.
    created_at: i64,

    /// Details on the filter criteria associated with this filter.
    criteria: FilterCriteria,

    /// A description of the filter.
    description: ?[]const u8,

    /// The name of the filter.
    name: []const u8,

    /// The Amazon Web Services account ID of the account that created the filter.
    owner_id: []const u8,

    /// The reason for the filter.
    reason: ?[]const u8,

    /// The tags attached to the filter.
    tags: ?[]const aws.map.StringMapEntry,

    /// The date and time the filter was last updated at.
    updated_at: i64,

    pub const json_field_names = .{
        .action = "action",
        .arn = "arn",
        .created_at = "createdAt",
        .criteria = "criteria",
        .description = "description",
        .name = "name",
        .owner_id = "ownerId",
        .reason = "reason",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
