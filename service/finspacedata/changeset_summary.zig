const aws = @import("aws");

const ChangeType = @import("change_type.zig").ChangeType;
const ChangesetErrorInfo = @import("changeset_error_info.zig").ChangesetErrorInfo;
const IngestionStatus = @import("ingestion_status.zig").IngestionStatus;

/// A Changeset is unit of data in a Dataset.
pub const ChangesetSummary = struct {
    /// Beginning time from which the Changeset is active. The value is determined
    /// as epoch time in milliseconds. For example, the value for Monday, November
    /// 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    active_from_timestamp: ?i64 = null,

    /// Time until which the Changeset is active. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    active_until_timestamp: ?i64 = null,

    /// The ARN identifier of the Changeset.
    changeset_arn: ?[]const u8 = null,

    /// The unique identifier for a Changeset.
    changeset_id: ?[]const u8 = null,

    /// Type that indicates how a Changeset is applied to a Dataset.
    ///
    /// * `REPLACE` – Changeset is considered as a replacement to all prior loaded
    /// Changesets.
    ///
    /// * `APPEND` – Changeset is considered as an addition to the end of all prior
    /// loaded Changesets.
    ///
    /// * `MODIFY` – Changeset is considered as a replacement to a specific prior
    /// ingested Changeset.
    change_type: ?ChangeType = null,

    /// The timestamp at which the Changeset was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: i64 = 0,

    /// The unique identifier for the FinSpace Dataset in which the Changeset is
    /// created.
    dataset_id: ?[]const u8 = null,

    /// The structure with error messages.
    error_info: ?ChangesetErrorInfo = null,

    /// Options that define the structure of the source file(s).
    format_params: ?[]const aws.map.StringMapEntry = null,

    /// Options that define the location of the data being ingested.
    source_params: ?[]const aws.map.StringMapEntry = null,

    /// Status of the Changeset ingestion.
    ///
    /// * `PENDING` – Changeset is pending creation.
    ///
    /// * `FAILED` – Changeset creation has failed.
    ///
    /// * `SUCCESS` – Changeset creation has succeeded.
    ///
    /// * `RUNNING` – Changeset creation is running.
    ///
    /// * `STOP_REQUESTED` – User requested Changeset creation to stop.
    status: ?IngestionStatus = null,

    /// The unique identifier of the updated Changeset.
    updated_by_changeset_id: ?[]const u8 = null,

    /// The unique identifier of the Changeset that is updated.
    updates_changeset_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_from_timestamp = "activeFromTimestamp",
        .active_until_timestamp = "activeUntilTimestamp",
        .changeset_arn = "changesetArn",
        .changeset_id = "changesetId",
        .change_type = "changeType",
        .create_time = "createTime",
        .dataset_id = "datasetId",
        .error_info = "errorInfo",
        .format_params = "formatParams",
        .source_params = "sourceParams",
        .status = "status",
        .updated_by_changeset_id = "updatedByChangesetId",
        .updates_changeset_id = "updatesChangesetId",
    };
};
