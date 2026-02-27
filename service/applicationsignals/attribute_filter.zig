/// A structure that defines a filter for narrowing down results based on
/// specific attribute values. This can be used to filter services by platform,
/// environment, or other service characteristics.
pub const AttributeFilter = struct {
    /// The name of the attribute to filter by, such as `Platform`, `Environment`,
    /// or `BusinessUnit`.
    attribute_filter_name: []const u8,

    /// An array of values to match for the specified attribute. Services that have
    /// any of these values for the attribute will be included in the results.
    attribute_filter_values: []const []const u8,

    pub const json_field_names = .{
        .attribute_filter_name = "AttributeFilterName",
        .attribute_filter_values = "AttributeFilterValues",
    };
};
