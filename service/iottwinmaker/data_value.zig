const aws = @import("aws");

const RelationshipValue = @import("relationship_value.zig").RelationshipValue;

/// An object that specifies a value for a property.
pub const DataValue = struct {
    /// A Boolean value.
    boolean_value: ?bool,

    /// A double value.
    double_value: ?f64,

    /// An expression that produces the value.
    expression: ?[]const u8,

    /// An integer value.
    integer_value: ?i32,

    /// A list of multiple values.
    list_value: ?[]const DataValue,

    /// A long value.
    long_value: ?i64,

    /// An object that maps strings to multiple `DataValue` objects.
    map_value: ?[]const aws.map.MapEntry(DataValue),

    /// A value that relates a component to another component.
    relationship_value: ?RelationshipValue,

    /// A string value.
    string_value: ?[]const u8,

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
