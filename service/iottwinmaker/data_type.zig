const DataValue = @import("data_value.zig").DataValue;
const Relationship = @import("relationship.zig").Relationship;
const Type = @import("type.zig").Type;

/// An object that specifies the data type of a property.
pub const DataType = struct {
    /// The allowed values for this data type.
    allowed_values: ?[]const DataValue = null,

    /// The nested type in the data type.
    nested_type: ?*DataType = null,

    /// A relationship that associates a component with another component.
    relationship: ?Relationship = null,

    /// The underlying type of the data type.
    @"type": Type,

    /// The unit of measure used in this data type.
    unit_of_measure: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .nested_type = "nestedType",
        .relationship = "relationship",
        .@"type" = "type",
        .unit_of_measure = "unitOfMeasure",
    };
};
