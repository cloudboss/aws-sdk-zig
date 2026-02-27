/// The properties that can be applied to a field when the connector is being
/// used as a
/// source.
pub const SourceFieldProperties = struct {
    /// Indicates if the field can be queried.
    is_queryable: bool = false,

    /// Indicates whether the field can be returned in a search result.
    is_retrievable: bool = false,

    /// Indicates if this timestamp field can be used for incremental queries.
    is_timestamp_field_for_incremental_queries: bool = false,

    pub const json_field_names = .{
        .is_queryable = "isQueryable",
        .is_retrievable = "isRetrievable",
        .is_timestamp_field_for_incremental_queries = "isTimestampFieldForIncrementalQueries",
    };
};
