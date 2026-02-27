const CustomFilterConfiguration = @import("custom_filter_configuration.zig").CustomFilterConfiguration;
const CustomFilterListConfiguration = @import("custom_filter_list_configuration.zig").CustomFilterListConfiguration;
const FilterListConfiguration = @import("filter_list_configuration.zig").FilterListConfiguration;

/// The configuration for a `CategoryFilter`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const CategoryFilterConfiguration = struct {
    /// A custom filter that filters based on a single value. This filter can be
    /// partially matched.
    custom_filter_configuration: ?CustomFilterConfiguration,

    /// A list of custom filter values. In the Quick Sight console, this filter type
    /// is called a custom filter list.
    custom_filter_list_configuration: ?CustomFilterListConfiguration,

    /// A list of filter configurations. In the Quick Sight console, this filter
    /// type is called a filter list.
    filter_list_configuration: ?FilterListConfiguration,

    pub const json_field_names = .{
        .custom_filter_configuration = "CustomFilterConfiguration",
        .custom_filter_list_configuration = "CustomFilterListConfiguration",
        .filter_list_configuration = "FilterListConfiguration",
    };
};
