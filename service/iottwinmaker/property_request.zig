const PropertyDefinitionRequest = @import("property_definition_request.zig").PropertyDefinitionRequest;
const PropertyUpdateType = @import("property_update_type.zig").PropertyUpdateType;
const DataValue = @import("data_value.zig").DataValue;

/// An object that sets information about a property.
pub const PropertyRequest = struct {
    /// An object that specifies information about a property.
    definition: ?PropertyDefinitionRequest,

    /// The update type of the update property request.
    update_type: ?PropertyUpdateType,

    /// The value of the property.
    value: ?DataValue,

    pub const json_field_names = .{
        .definition = "definition",
        .update_type = "updateType",
        .value = "value",
    };
};
