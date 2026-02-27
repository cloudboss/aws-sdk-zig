const Filter = @import("filter.zig").Filter;

/// A list of nested
/// [Filter](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Filter.html) objects. A resource must satisfy the conditions of all filters to be included in the results returned from the [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API.
///
/// For example, to filter on a training job's `InputDataConfig` property with a
/// specific channel name and `S3Uri` prefix, define the following filters:
///
/// * `'{Name:"InputDataConfig.ChannelName", "Operator":"Equals",
///   "Value":"train"}',`
/// * `'{Name:"InputDataConfig.DataSource.S3DataSource.S3Uri",
///   "Operator":"Contains", "Value":"mybucket/catdata"}'`
pub const NestedFilters = struct {
    /// A list of filters. Each filter acts on a property. Filters must contain at
    /// least one `Filters` value. For example, a `NestedFilters` call might include
    /// a filter on the `PropertyName` parameter of the `InputDataConfig` property:
    /// `InputDataConfig.DataSource.S3DataSource.S3Uri`.
    filters: []const Filter,

    /// The name of the property to use in the nested filters. The value must match
    /// a listed property name, such as `InputDataConfig`.
    nested_property_name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .nested_property_name = "NestedPropertyName",
    };
};
