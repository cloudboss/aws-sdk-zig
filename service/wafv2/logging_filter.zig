const FilterBehavior = @import("filter_behavior.zig").FilterBehavior;
const Filter = @import("filter.zig").Filter;

/// Filtering that specifies which web requests are kept in the logs and which
/// are dropped,
/// defined for a web ACL's LoggingConfiguration.
///
/// You can filter on the rule action and on the web request labels that were
/// applied by
/// matching rules during web ACL evaluation.
pub const LoggingFilter = struct {
    /// Default handling for logs that don't match any of the specified filtering
    /// conditions.
    default_behavior: FilterBehavior,

    /// The filters that you want to apply to the logs.
    filters: []const Filter,

    pub const json_field_names = .{
        .default_behavior = "DefaultBehavior",
        .filters = "Filters",
    };
};
