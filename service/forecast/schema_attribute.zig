const AttributeType = @import("attribute_type.zig").AttributeType;

/// An attribute of a schema, which defines a dataset field. A schema attribute
/// is required
/// for every field in a dataset. The
/// [Schema](https://docs.aws.amazon.com/forecast/latest/dg/API_Schema.html)
/// object contains an array of
/// `SchemaAttribute` objects.
pub const SchemaAttribute = struct {
    /// The name of the dataset field.
    attribute_name: ?[]const u8 = null,

    /// The data type of the field.
    ///
    /// For a related time series dataset, other than date, item_id, and forecast
    /// dimensions attributes, all attributes should be of numerical type
    /// (integer/float).
    attribute_type: ?AttributeType = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_type = "AttributeType",
    };
};
