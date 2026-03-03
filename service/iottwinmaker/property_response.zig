const PropertyDefinitionResponse = @import("property_definition_response.zig").PropertyDefinitionResponse;
const DataValue = @import("data_value.zig").DataValue;

/// An object that contains information about a property response.
pub const PropertyResponse = struct {
    /// This flag notes whether all values of a list or map type property are
    /// returned in the API response. The maximum number of values per property
    /// returned is 50.
    are_all_property_values_returned: ?bool = null,

    /// An object that specifies information about a property.
    definition: ?PropertyDefinitionResponse = null,

    /// The value of the property.
    value: ?DataValue = null,

    pub const json_field_names = .{
        .are_all_property_values_returned = "areAllPropertyValuesReturned",
        .definition = "definition",
        .value = "value",
    };
};
