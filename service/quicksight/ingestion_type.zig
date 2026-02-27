/// This defines the type of ingestion user wants to trigger. This is part of
/// create ingestion request.
pub const IngestionType = enum {
    incremental_refresh,
    full_refresh,

    pub const json_field_names = .{
        .incremental_refresh = "INCREMENTAL_REFRESH",
        .full_refresh = "FULL_REFRESH",
    };
};
