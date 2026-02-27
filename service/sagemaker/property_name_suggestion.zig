/// A property name returned from a `GetSearchSuggestions` call that specifies a
/// value in the `PropertyNameQuery` field.
pub const PropertyNameSuggestion = struct {
    /// A suggested property name based on what you entered in the search textbox in
    /// the SageMaker console.
    property_name: ?[]const u8,

    pub const json_field_names = .{
        .property_name = "PropertyName",
    };
};
