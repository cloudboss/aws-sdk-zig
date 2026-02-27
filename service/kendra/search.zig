/// Provides information about how a custom index field is used during a search.
pub const Search = struct {
    /// Determines whether the field is returned in the query response. The default
    /// is
    /// `true`.
    displayable: bool = false,

    /// Indicates that the field can be used to create search facets, a count of
    /// results for
    /// each value in the field. The default is `false` .
    facetable: bool = false,

    /// Determines whether the field is used in the search. If the `Searchable`
    /// field is `true`, you can use relevance tuning to manually tune how Amazon
    /// Kendra weights the field in the search. The default is `true` for
    /// string fields and `false` for number and date fields.
    searchable: bool = false,

    /// Determines whether the field can be used to sort the results of a query. If
    /// you
    /// specify sorting on a field that does not have `Sortable` set to
    /// `true`, Amazon Kendra returns an exception. The default is
    /// `false`.
    sortable: bool = false,

    pub const json_field_names = .{
        .displayable = "Displayable",
        .facetable = "Facetable",
        .searchable = "Searchable",
        .sortable = "Sortable",
    };
};
