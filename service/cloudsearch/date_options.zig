/// Options for a date field. Dates and times are specified in UTC (Coordinated
/// Universal Time) according to IETF RFC3339: yyyy-mm-ddT00:00:00Z. Present if
/// `IndexFieldType` specifies the field is of type `date`. All options are
/// enabled by default.
pub const DateOptions = struct {
    /// A value to use for the field if the field isn't specified for a document.
    default_value: ?[]const u8,

    /// Whether facet information can be returned for the field.
    facet_enabled: ?bool,

    /// Whether the contents of the field can be returned in the search results.
    return_enabled: ?bool,

    /// Whether the contents of the field are searchable.
    search_enabled: ?bool,

    /// Whether the field can be used to sort the search results.
    sort_enabled: ?bool,

    source_field: ?[]const u8,
};
