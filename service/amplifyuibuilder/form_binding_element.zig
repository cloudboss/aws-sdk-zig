/// Describes how to bind a component property to form data.
pub const FormBindingElement = struct {
    /// The name of the component to retrieve a value from.
    element: []const u8,

    /// The property to retrieve a value from.
    property: []const u8,

    pub const json_field_names = .{
        .element = "element",
        .property = "property",
    };
};
