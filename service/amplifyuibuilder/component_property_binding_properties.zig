/// Associates a component property to a binding property. This enables exposed
/// properties on
/// the top level component to propagate data to the component's property
/// values.
pub const ComponentPropertyBindingProperties = struct {
    /// The data field to bind the property to.
    field: ?[]const u8 = null,

    /// The component property to bind to the data field.
    property: []const u8,

    pub const json_field_names = .{
        .field = "field",
        .property = "property",
    };
};
