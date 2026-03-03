const ExecutionResult = @import("execution_result.zig").ExecutionResult;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const MetadataCatalogDetail = @import("metadata_catalog_detail.zig").MetadataCatalogDetail;

/// Specifies information about the past flow run instances for a given flow.
pub const ExecutionRecord = struct {
    /// The timestamp that indicates the last new or updated record to be
    /// transferred in the flow
    /// run.
    data_pull_end_time: ?i64 = null,

    /// The timestamp that determines the first new or updated record to be
    /// transferred in the
    /// flow run.
    data_pull_start_time: ?i64 = null,

    /// Specifies the identifier of the given flow run.
    execution_id: ?[]const u8 = null,

    /// Describes the result of the given flow run.
    execution_result: ?ExecutionResult = null,

    /// Specifies the flow run status and whether it is in progress, has completed
    /// successfully,
    /// or has failed.
    execution_status: ?ExecutionStatus = null,

    /// Specifies the time of the most recent update.
    last_updated_at: ?i64 = null,

    /// Describes the metadata catalog, metadata table, and data partitions that
    /// Amazon AppFlow used for the associated flow run.
    metadata_catalog_details: ?[]const MetadataCatalogDetail = null,

    /// Specifies the start time of the flow run.
    started_at: ?i64 = null,

    pub const json_field_names = .{
        .data_pull_end_time = "dataPullEndTime",
        .data_pull_start_time = "dataPullStartTime",
        .execution_id = "executionId",
        .execution_result = "executionResult",
        .execution_status = "executionStatus",
        .last_updated_at = "lastUpdatedAt",
        .metadata_catalog_details = "metadataCatalogDetails",
        .started_at = "startedAt",
    };
};
