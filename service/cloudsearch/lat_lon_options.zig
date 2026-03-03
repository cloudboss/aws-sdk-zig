/// Options for a latlon field. A latlon field contains a location stored as a
/// latitude and longitude value pair. Present if `IndexFieldType` specifies the
/// field is of type `latlon`. All options are enabled by default.
pub const LatLonOptions = struct {
    /// A value to use for the field if the field isn't specified for a document.
    default_value: ?[]const u8 = null,

    /// Whether facet information can be returned for the field.
    facet_enabled: ?bool = null,

    /// Whether the contents of the field can be returned in the search results.
    return_enabled: ?bool = null,

    /// Whether the contents of the field are searchable.
    search_enabled: ?bool = null,

    /// Whether the field can be used to sort the search results.
    sort_enabled: ?bool = null,

    source_field: ?[]const u8 = null,
};
