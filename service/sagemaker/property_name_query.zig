/// Part of the `SuggestionQuery` type. Specifies a hint for retrieving property
/// names that begin with the specified text.
pub const PropertyNameQuery = struct {
    /// Text that begins a property's name.
    property_name_hint: []const u8,

    pub const json_field_names = .{
        .property_name_hint = "PropertyNameHint",
    };
};
