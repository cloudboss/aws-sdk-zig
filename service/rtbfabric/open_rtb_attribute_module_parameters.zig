const Action = @import("action.zig").Action;
const Filter = @import("filter.zig").Filter;
const FilterType = @import("filter_type.zig").FilterType;

/// Describes the parameters of an open RTB attribute module.
pub const OpenRtbAttributeModuleParameters = struct {
    /// Describes a bid action.
    action: Action,

    /// Describes the configuration of a filter.
    filter_configuration: []const Filter,

    /// The filter type.
    filter_type: FilterType,

    /// The hold back percentage.
    holdback_percentage: f32,

    pub const json_field_names = .{
        .action = "action",
        .filter_configuration = "filterConfiguration",
        .filter_type = "filterType",
        .holdback_percentage = "holdbackPercentage",
    };
};
