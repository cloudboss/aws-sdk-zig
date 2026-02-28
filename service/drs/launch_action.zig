const aws = @import("aws");

const LaunchActionCategory = @import("launch_action_category.zig").LaunchActionCategory;
const LaunchActionParameter = @import("launch_action_parameter.zig").LaunchActionParameter;
const LaunchActionType = @import("launch_action_type.zig").LaunchActionType;

/// Launch action.
pub const LaunchAction = struct {
    /// Launch action code.
    action_code: ?[]const u8,

    action_id: ?[]const u8,

    action_version: ?[]const u8,

    /// Whether the launch action is active.
    active: ?bool,

    category: ?LaunchActionCategory,

    description: ?[]const u8,

    name: ?[]const u8,

    /// Whether the launch will not be marked as failed if this action fails.
    optional: ?bool,

    order: ?i32,

    parameters: ?[]const aws.map.MapEntry(LaunchActionParameter),

    /// Launch action type.
    @"type": ?LaunchActionType,

    pub const json_field_names = .{
        .action_code = "actionCode",
        .action_id = "actionId",
        .action_version = "actionVersion",
        .active = "active",
        .category = "category",
        .description = "description",
        .name = "name",
        .optional = "optional",
        .order = "order",
        .parameters = "parameters",
        .@"type" = "type",
    };
};
