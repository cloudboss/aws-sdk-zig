const EntityPropertyReference = @import("entity_property_reference.zig").EntityPropertyReference;
const PropertyValue = @import("property_value.zig").PropertyValue;

/// The history of values for a time series property.
pub const PropertyValueHistory = struct {
    /// An object that uniquely identifies an entity property.
    entity_property_reference: EntityPropertyReference,

    /// A list of objects that contain information about the values in the history
    /// of a time
    /// series property.
    values: ?[]const PropertyValue,

    pub const json_field_names = .{
        .entity_property_reference = "entityPropertyReference",
        .values = "values",
    };
};
