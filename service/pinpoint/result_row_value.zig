/// Provides a single value and metadata about that value as part of an array of
/// query results for a standard metric that applies to an application,
/// campaign, or journey.
pub const ResultRowValue = struct {
    /// The friendly name of the metric whose value is specified by the Value
    /// property.
    key: []const u8,

    /// The data type of the value specified by the Value property.
    @"type": []const u8,

    /// In a Values object, the value for the metric that the query retrieved data
    /// for. In a GroupedBys object, the value for the field that was used to group
    /// data in a result set that contains multiple results (Values objects).
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .@"type" = "Type",
        .value = "Value",
    };
};
