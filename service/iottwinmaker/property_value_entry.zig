const EntityPropertyReference = @import("entity_property_reference.zig").EntityPropertyReference;
const PropertyValue = @import("property_value.zig").PropertyValue;

/// An object that specifies information about time series property values. This
/// object is
/// used and consumed by the
/// [BatchPutPropertyValues](https://docs.aws.amazon.com/iot-twinmaker/latest/apireference/API_BatchPutPropertyValues.html) action.
pub const PropertyValueEntry = struct {
    /// An object that contains information about the entity that has the property.
    entity_property_reference: EntityPropertyReference,

    /// A list of objects that specify time series property values.
    property_values: ?[]const PropertyValue = null,

    pub const json_field_names = .{
        .entity_property_reference = "entityPropertyReference",
        .property_values = "propertyValues",
    };
};
