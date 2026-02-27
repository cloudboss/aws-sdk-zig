/// Options for text field. Present if `IndexFieldType` specifies the field is
/// of type `text`. A `text` field is always searchable. All options are enabled
/// by default.
pub const TextOptions = struct {
    /// The name of an analysis scheme for a `text` field.
    analysis_scheme: ?[]const u8,

    /// A value to use for the field if the field isn't specified for a document.
    default_value: ?[]const u8,

    /// Whether highlights can be returned for the field.
    highlight_enabled: ?bool,

    /// Whether the contents of the field can be returned in the search results.
    return_enabled: ?bool,

    /// Whether the field can be used to sort the search results.
    sort_enabled: ?bool,

    source_field: ?[]const u8,
};
