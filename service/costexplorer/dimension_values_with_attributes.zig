const aws = @import("aws");

/// The metadata of a specific type that you can use to filter and group your
/// results. You
/// can use `GetDimensionValues` to find specific values.
pub const DimensionValuesWithAttributes = struct {
    /// The attribute that applies to a specific `Dimension`.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The value of a dimension with a specific attribute.
    value: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .value = "Value",
    };
};
