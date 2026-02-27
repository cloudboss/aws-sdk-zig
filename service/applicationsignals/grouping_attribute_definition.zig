/// A structure that defines how services should be grouped based on specific
/// attributes. This includes the friendly name for the grouping, the source
/// keys to derive values from, and an optional default value.
pub const GroupingAttributeDefinition = struct {
    /// The default value to use for this grouping attribute when no value can be
    /// derived from the source keys. This ensures all services have a grouping
    /// value even if the source data is missing.
    default_grouping_value: ?[]const u8,

    /// The friendly name for this grouping attribute, such as `BusinessUnit` or
    /// `Environment`. This name is used to identify the grouping in the console and
    /// APIs.
    grouping_name: []const u8,

    /// An array of source keys used to derive the grouping attribute value from
    /// telemetry data, Amazon Web Services tags, or other sources. For example,
    /// ["business_unit", "team"] would look for values in those fields.
    grouping_source_keys: ?[]const []const u8,

    pub const json_field_names = .{
        .default_grouping_value = "DefaultGroupingValue",
        .grouping_name = "GroupingName",
        .grouping_source_keys = "GroupingSourceKeys",
    };
};
