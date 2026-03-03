const PropertyDefinitionResponse = @import("property_definition_response.zig").PropertyDefinitionResponse;
const DataValue = @import("data_value.zig").DataValue;

/// This is an object that contains the information of a property.
pub const PropertySummary = struct {
    /// This flag notes whether all values of a list or map type property are
    /// returned in the API
    /// response. The maximum number of values per property returned is 50.
    are_all_property_values_returned: ?bool = null,

    /// This is the schema for the property.
    definition: ?PropertyDefinitionResponse = null,

    /// This is the name of the property.
    property_name: []const u8,

    /// This is the value for the property.
    value: ?DataValue = null,

    pub const json_field_names = .{
        .are_all_property_values_returned = "areAllPropertyValuesReturned",
        .definition = "definition",
        .property_name = "propertyName",
        .value = "value",
    };
};
