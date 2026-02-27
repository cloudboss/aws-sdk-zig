/// This defines the type of ingestion request. This is returned as part of
/// create ingestion response.
pub const IngestionRequestType = enum {
    initial_ingestion,
    edit,
    incremental_refresh,
    full_refresh,

    pub const json_field_names = .{
        .initial_ingestion = "INITIAL_INGESTION",
        .edit = "EDIT",
        .incremental_refresh = "INCREMENTAL_REFRESH",
        .full_refresh = "FULL_REFRESH",
    };
};
