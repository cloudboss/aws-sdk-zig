const CrossDatasetTypes = @import("cross_dataset_types.zig").CrossDatasetTypes;
const Filter = @import("filter.zig").Filter;
const FilterScopeConfiguration = @import("filter_scope_configuration.zig").FilterScopeConfiguration;
const WidgetStatus = @import("widget_status.zig").WidgetStatus;

/// A grouping of individual filters. Filter groups are applied to the same
/// group of visuals.
///
/// For more information, see [Adding filter conditions (group filters) with AND
/// and OR
/// operators](https://docs.aws.amazon.com/quicksight/latest/user/add-a-compound-filter.html) in the *Amazon Quick Suite User Guide*.
pub const FilterGroup = struct {
    /// The filter new feature which can apply filter group to all data sets. Choose
    /// one of the following options:
    ///
    /// * `ALL_DATASETS`
    ///
    /// * `SINGLE_DATASET`
    cross_dataset: CrossDatasetTypes,

    /// The value that uniquely identifies a `FilterGroup` within a dashboard,
    /// template, or analysis.
    filter_group_id: []const u8,

    /// The list of filters that are present in a `FilterGroup`.
    filters: []const Filter,

    /// The configuration that specifies what scope to apply to a `FilterGroup`.
    ///
    /// This is a union type structure. For this structure to be valid, only one of
    /// the attributes can be defined.
    scope_configuration: FilterScopeConfiguration,

    /// The status of the `FilterGroup`.
    status: ?WidgetStatus = null,

    pub const json_field_names = .{
        .cross_dataset = "CrossDataset",
        .filter_group_id = "FilterGroupId",
        .filters = "Filters",
        .scope_configuration = "ScopeConfiguration",
        .status = "Status",
    };
};
