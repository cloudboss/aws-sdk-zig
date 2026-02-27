/// The collection of components that defines the time-series.
pub const TimeSeriesConfig = struct {
    /// A set of columns names that can be grouped with the item identifier column
    /// to create a composite key for which a target value is predicted.
    grouping_attribute_names: ?[]const []const u8,

    /// The name of the column that represents the set of item identifiers for which
    /// you want to predict the target value.
    item_identifier_attribute_name: []const u8,

    /// The name of the column representing the target variable that you want to
    /// predict for each item in your dataset. The data type of the target variable
    /// must be numerical.
    target_attribute_name: []const u8,

    /// The name of the column indicating a point in time at which the target value
    /// of a given item is recorded.
    timestamp_attribute_name: []const u8,

    pub const json_field_names = .{
        .grouping_attribute_names = "GroupingAttributeNames",
        .item_identifier_attribute_name = "ItemIdentifierAttributeName",
        .target_attribute_name = "TargetAttributeName",
        .timestamp_attribute_name = "TimestampAttributeName",
    };
};
