/// Options for a field that contains an array of text strings. Present if
/// `IndexFieldType` specifies the field is of type `text-array`. A `text-array`
/// field is always searchable. All options are enabled by default.
pub const TextArrayOptions = struct {
    /// The name of an analysis scheme for a `text-array` field.
    analysis_scheme: ?[]const u8,

    /// A value to use for the field if the field isn't specified for a document.
    default_value: ?[]const u8,

    /// Whether highlights can be returned for the field.
    highlight_enabled: ?bool,

    /// Whether the contents of the field can be returned in the search results.
    return_enabled: ?bool,

    /// A list of source fields to map to the field.
    source_fields: ?[]const u8,
};
