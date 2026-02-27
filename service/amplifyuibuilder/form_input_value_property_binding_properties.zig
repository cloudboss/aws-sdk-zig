/// Associates a form property to a binding property. This enables exposed
/// properties on the
/// top level form to propagate data to the form's property values.
pub const FormInputValuePropertyBindingProperties = struct {
    /// The data field to bind the property to.
    field: ?[]const u8,

    /// The form property to bind to the data field.
    property: []const u8,

    pub const json_field_names = .{
        .field = "field",
        .property = "property",
    };
};
