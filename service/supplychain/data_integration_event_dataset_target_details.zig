const DataIntegrationEventDatasetLoadExecutionDetails = @import("data_integration_event_dataset_load_execution_details.zig").DataIntegrationEventDatasetLoadExecutionDetails;
const DataIntegrationEventDatasetOperationType = @import("data_integration_event_dataset_operation_type.zig").DataIntegrationEventDatasetOperationType;

/// The target dataset details for a DATASET event type.
pub const DataIntegrationEventDatasetTargetDetails = struct {
    /// The datalake dataset ARN identifier.
    dataset_identifier: []const u8,

    /// The target dataset load execution.
    dataset_load_execution: DataIntegrationEventDatasetLoadExecutionDetails,

    /// The target dataset load operation type. The available options are:
    ///
    /// * **APPEND** - Add new records to the dataset. Noted that this operation
    ///   type will just try to append records as-is without any primary key or
    ///   partition constraints.
    ///
    /// * **UPSERT** - Modify existing records in the dataset with primary key
    ///   configured, events for datasets without primary keys are not allowed. If
    ///   event data contains primary keys that match records in the dataset within
    ///   same partition, then those existing records (in that partition) will be
    ///   updated. If primary keys do not match, new records will be added. Note
    ///   that if dataset contain records with duplicate primary key values in the
    ///   same partition, those duplicate records will be deduped into one updated
    ///   record.
    ///
    /// * **DELETE** - Remove existing records in the dataset with primary key
    ///   configured, events for datasets without primary keys are not allowed. If
    ///   event data contains primary keys that match records in the dataset within
    ///   same partition, then those existing records (in that partition) will be
    ///   deleted. If primary keys do not match, no actions will be done. Note that
    ///   if dataset contain records with duplicate primary key values in the same
    ///   partition, all those duplicates will be removed.
    operation_type: DataIntegrationEventDatasetOperationType,

    pub const json_field_names = .{
        .dataset_identifier = "datasetIdentifier",
        .dataset_load_execution = "datasetLoadExecution",
        .operation_type = "operationType",
    };
};
