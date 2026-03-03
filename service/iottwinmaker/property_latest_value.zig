const EntityPropertyReference = @import("entity_property_reference.zig").EntityPropertyReference;
const DataValue = @import("data_value.zig").DataValue;

/// The latest value of the property.
pub const PropertyLatestValue = struct {
    /// An object that specifies information about a property.
    property_reference: EntityPropertyReference,

    /// The value of the property.
    property_value: ?DataValue = null,

    pub const json_field_names = .{
        .property_reference = "propertyReference",
        .property_value = "propertyValue",
    };
};
