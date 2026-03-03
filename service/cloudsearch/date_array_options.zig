/// Options for a field that contains an array of dates. Present if
/// `IndexFieldType` specifies the field is of type `date-array`. All options
/// are enabled by default.
pub const DateArrayOptions = struct {
    /// A value to use for the field if the field isn't specified for a document.
    default_value: ?[]const u8 = null,

    /// Whether facet information can be returned for the field.
    facet_enabled: ?bool = null,

    /// Whether the contents of the field can be returned in the search results.
    return_enabled: ?bool = null,

    /// Whether the contents of the field are searchable.
    search_enabled: ?bool = null,

    /// A list of source fields to map to the field.
    source_fields: ?[]const u8 = null,
};
