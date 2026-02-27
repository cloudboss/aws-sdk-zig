/// Options for a field that contains an array of 64-bit signed integers.
/// Present if `IndexFieldType` specifies the field is of type `int-array`. All
/// options are enabled by default.
pub const IntArrayOptions = struct {
    /// A value to use for the field if the field isn't specified for a document.
    default_value: ?i64,

    /// Whether facet information can be returned for the field.
    facet_enabled: ?bool,

    /// Whether the contents of the field can be returned in the search results.
    return_enabled: ?bool,

    /// Whether the contents of the field are searchable.
    search_enabled: ?bool,

    /// A list of source fields to map to the field.
    source_fields: ?[]const u8,
};
