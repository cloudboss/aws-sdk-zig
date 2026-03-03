const FilterBehavior = @import("filter_behavior.zig").FilterBehavior;
const Filter = @import("filter.zig").Filter;

/// Configuration that determines which WAF log records to keep or drop based on
/// specified conditions.
pub const LoggingFilter = struct {
    /// The default action (KEEP or DROP) for log records that don't match any
    /// filter conditions.
    default_behavior: ?FilterBehavior = null,

    /// A list of filter conditions that determine log record handling behavior.
    filters: ?[]const Filter = null,

    pub const json_field_names = .{
        .default_behavior = "DefaultBehavior",
        .filters = "Filters",
    };
};
