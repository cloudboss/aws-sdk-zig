const aws = @import("aws");

const RelationshipValue = @import("relationship_value.zig").RelationshipValue;

/// An object that specifies a value for a property.
pub const DataValue = struct {
    /// A Boolean value.
    boolean_value: ?bool = null,

    /// A double value.
    double_value: ?f64 = null,

    /// An expression that produces the value.
    expression: ?[]const u8 = null,

    /// An integer value.
    integer_value: ?i32 = null,

    /// A list of multiple values.
    list_value: ?[]const DataValue = null,

    /// A long value.
    long_value: ?i64 = null,

    /// An object that maps strings to multiple `DataValue` objects.
    map_value: ?[]const aws.map.MapEntry(DataValue) = null,

    /// A value that relates a component to another component.
    relationship_value: ?RelationshipValue = null,

    /// A string value.
    string_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .expression = "expression",
        .integer_value = "integerValue",
        .list_value = "listValue",
        .long_value = "longValue",
        .map_value = "mapValue",
        .relationship_value = "relationshipValue",
        .string_value = "stringValue",
    };
};
