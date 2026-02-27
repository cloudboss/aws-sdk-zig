/// Options for a double-precision 64-bit floating point field. Present if
/// `IndexFieldType` specifies the field is of type `double`. All options are
/// enabled by default.
pub const DoubleOptions = struct {
    /// A value to use for the field if the field isn't specified for a document.
    /// This can be important if you are using the field in an expression and that
    /// field is not present in every document.
    default_value: ?f64,

    /// Whether facet information can be returned for the field.
    facet_enabled: ?bool,

    /// Whether the contents of the field can be returned in the search results.
    return_enabled: ?bool,

    /// Whether the contents of the field are searchable.
    search_enabled: ?bool,

    /// Whether the field can be used to sort the search results.
    sort_enabled: ?bool,

    /// The name of the source field to map to the field.
    source_field: ?[]const u8,
};
