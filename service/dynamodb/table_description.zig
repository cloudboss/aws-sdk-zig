const ArchivalSummary = @import("archival_summary.zig").ArchivalSummary;
const AttributeDefinition = @import("attribute_definition.zig").AttributeDefinition;
const BillingModeSummary = @import("billing_mode_summary.zig").BillingModeSummary;
const GlobalSecondaryIndexDescription = @import("global_secondary_index_description.zig").GlobalSecondaryIndexDescription;
const GlobalTableSettingsReplicationMode = @import("global_table_settings_replication_mode.zig").GlobalTableSettingsReplicationMode;
const GlobalTableWitnessDescription = @import("global_table_witness_description.zig").GlobalTableWitnessDescription;
const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const LocalSecondaryIndexDescription = @import("local_secondary_index_description.zig").LocalSecondaryIndexDescription;
const MultiRegionConsistency = @import("multi_region_consistency.zig").MultiRegionConsistency;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const ProvisionedThroughputDescription = @import("provisioned_throughput_description.zig").ProvisionedThroughputDescription;
const ReplicaDescription = @import("replica_description.zig").ReplicaDescription;
const RestoreSummary = @import("restore_summary.zig").RestoreSummary;
const SSEDescription = @import("sse_description.zig").SSEDescription;
const StreamSpecification = @import("stream_specification.zig").StreamSpecification;
const TableClassSummary = @import("table_class_summary.zig").TableClassSummary;
const TableStatus = @import("table_status.zig").TableStatus;
const TableWarmThroughputDescription = @import("table_warm_throughput_description.zig").TableWarmThroughputDescription;

/// Represents the properties of a table.
pub const TableDescription = struct {
    /// Contains information about the table archive.
    archival_summary: ?ArchivalSummary,

    /// An array of `AttributeDefinition` objects. Each of these objects describes
    /// one attribute in the table and index key schema.
    ///
    /// Each `AttributeDefinition` object in this array is composed of:
    ///
    /// * `AttributeName` - The name of the attribute.
    ///
    /// * `AttributeType` - The data type for the attribute.
    attribute_definitions: ?[]const AttributeDefinition,

    /// Contains the details for the read/write capacity mode.
    billing_mode_summary: ?BillingModeSummary,

    /// The date and time when the table was created, in [UNIX epoch
    /// time](http://www.epochconverter.com/) format.
    creation_date_time: ?i64,

    /// Indicates whether deletion protection is enabled (true) or disabled (false)
    /// on the
    /// table.
    deletion_protection_enabled: ?bool,

    /// The global secondary indexes, if any, on the table. Each index is scoped to
    /// a given
    /// partition key value. Each element is composed of:
    ///
    /// * `Backfilling` - If true, then the index is currently in the
    /// backfilling phase. Backfilling occurs only when a new global secondary index
    /// is
    /// added to the table. It is the process by which DynamoDB populates the new
    /// index
    /// with data from the table. (This attribute does not appear for indexes that
    /// were
    /// created during a `CreateTable` operation.)
    ///
    /// You can delete an index that is being created during the
    /// `Backfilling` phase when `IndexStatus` is set to
    /// CREATING and `Backfilling` is true. You can't delete the index that
    /// is being created when `IndexStatus` is set to CREATING and
    /// `Backfilling` is false. (This attribute does not appear for
    /// indexes that were created during a `CreateTable` operation.)
    ///
    /// * `IndexName` - The name of the global secondary index.
    ///
    /// * `IndexSizeBytes` - The total size of the global secondary index, in
    /// bytes. DynamoDB updates this value approximately every six hours. Recent
    /// changes
    /// might not be reflected in this value.
    ///
    /// * `IndexStatus` - The current status of the global secondary
    /// index:
    ///
    /// * `CREATING` - The index is being created.
    ///
    /// * `UPDATING` - The index is being updated.
    ///
    /// * `DELETING` - The index is being deleted.
    ///
    /// * `ACTIVE` - The index is ready for use.
    ///
    /// * `ItemCount` - The number of items in the global secondary index.
    /// DynamoDB updates this value approximately every six hours. Recent changes
    /// might
    /// not be reflected in this value.
    ///
    /// * `KeySchema` - Specifies the complete index key schema. The attribute
    /// names in the key schema must be between 1 and 255 characters (inclusive).
    /// The
    /// key schema must begin with the same partition key as the table.
    ///
    /// * `Projection` - Specifies attributes that are copied (projected) from
    /// the table into the index. These are in addition to the primary key
    /// attributes
    /// and index key attributes, which are automatically projected. Each attribute
    /// specification is composed of:
    ///
    /// * `ProjectionType` - One of the following:
    ///
    /// * `KEYS_ONLY` - Only the index and primary keys are
    /// projected into the index.
    ///
    /// * `INCLUDE` - In addition to the attributes described
    /// in `KEYS_ONLY`, the secondary index will include
    /// other non-key attributes that you specify.
    ///
    /// * `ALL` - All of the table attributes are projected
    /// into the index.
    ///
    /// * `NonKeyAttributes` - A list of one or more non-key attribute
    /// names that are projected into the secondary index. The total count of
    /// attributes provided in `NonKeyAttributes`, summed across all
    /// of the secondary indexes, must not exceed 100. If you project the same
    /// attribute into two different indexes, this counts as two distinct
    /// attributes when determining the total. This limit only applies when you
    /// specify the ProjectionType of `INCLUDE`. You still can
    /// specify the ProjectionType of `ALL` to project all attributes
    /// from the source table, even if the table has more than 100
    /// attributes.
    ///
    /// * `ProvisionedThroughput` - The provisioned throughput settings for the
    /// global secondary index, consisting of read and write capacity units, along
    /// with
    /// data about increases and decreases.
    ///
    /// If the table is in the `DELETING` state, no information about indexes will
    /// be returned.
    global_secondary_indexes: ?[]const GlobalSecondaryIndexDescription,

    /// Indicates one of the settings synchronization modes for the global table:
    ///
    /// * `ENABLED`: Indicates that the settings synchronization mode for the global
    ///   table
    /// is enabled.
    ///
    /// * `DISABLED`: Indicates that the settings synchronization mode for the
    ///   global table is
    /// disabled.
    ///
    /// * `ENABLED_WITH_OVERRIDES`: This mode is set by default for a same account
    ///   global table.
    /// Indicates that certain global table settings can be overridden.
    global_table_settings_replication_mode: ?GlobalTableSettingsReplicationMode,

    /// Represents the version of [global
    /// tables](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GlobalTables.html)
    /// in use, if the table is replicated across Amazon Web Services Regions.
    global_table_version: ?[]const u8,

    /// The witness Region and its current status in the MRSC global table. Only one
    /// witness
    /// Region can be configured per MRSC global table.
    global_table_witnesses: ?[]const GlobalTableWitnessDescription,

    /// The number of items in the specified table. DynamoDB updates this value
    /// approximately
    /// every six hours. Recent changes might not be reflected in this value.
    item_count: ?i64,

    /// The primary key structure for the table. Each `KeySchemaElement` consists
    /// of:
    ///
    /// * `AttributeName` - The name of the attribute.
    ///
    /// * `KeyType` - The role of the attribute:
    ///
    /// * `HASH` - partition key
    ///
    /// * `RANGE` - sort key
    ///
    /// **Note:**
    ///
    /// The partition key of an item is also known as its *hash
    /// attribute*. The term "hash attribute" derives from DynamoDB's
    /// usage of an internal hash function to evenly distribute data items across
    /// partitions, based on their partition key values.
    ///
    /// The sort key of an item is also known as its *range
    /// attribute*. The term "range attribute" derives from the way
    /// DynamoDB stores items with the same partition key physically close together,
    /// in sorted order by the sort key value.
    ///
    /// For more information about primary keys, see [Primary
    /// Key](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DataModel.html#DataModelPrimaryKey) in the *Amazon DynamoDB Developer
    /// Guide*.
    key_schema: ?[]const KeySchemaElement,

    /// The Amazon Resource Name (ARN) that uniquely identifies the latest stream
    /// for this
    /// table.
    latest_stream_arn: ?[]const u8,

    /// A timestamp, in ISO 8601 format, for this stream.
    ///
    /// Note that `LatestStreamLabel` is not a unique identifier for the stream,
    /// because it is possible that a stream from another table might have the same
    /// timestamp.
    /// However, the combination of the following three elements is guaranteed to be
    /// unique:
    ///
    /// * Amazon Web Services customer ID
    ///
    /// * Table name
    ///
    /// * `StreamLabel`
    latest_stream_label: ?[]const u8,

    /// Represents one or more local secondary indexes on the table. Each index is
    /// scoped to a
    /// given partition key value. Tables with one or more local secondary indexes
    /// are subject
    /// to an item collection size limit, where the amount of data within a given
    /// item
    /// collection cannot exceed 10 GB. Each element is composed of:
    ///
    /// * `IndexName` - The name of the local secondary index.
    ///
    /// * `KeySchema` - Specifies the complete index key schema. The attribute
    /// names in the key schema must be between 1 and 255 characters (inclusive).
    /// The
    /// key schema must begin with the same partition key as the table.
    ///
    /// * `Projection` - Specifies attributes that are copied (projected) from
    /// the table into the index. These are in addition to the primary key
    /// attributes
    /// and index key attributes, which are automatically projected. Each attribute
    /// specification is composed of:
    ///
    /// * `ProjectionType` - One of the following:
    ///
    /// * `KEYS_ONLY` - Only the index and primary keys are
    /// projected into the index.
    ///
    /// * `INCLUDE` - Only the specified table attributes are
    /// projected into the index. The list of projected attributes is in
    /// `NonKeyAttributes`.
    ///
    /// * `ALL` - All of the table attributes are projected
    /// into the index.
    ///
    /// * `NonKeyAttributes` - A list of one or more non-key attribute
    /// names that are projected into the secondary index. The total count of
    /// attributes provided in `NonKeyAttributes`, summed across all
    /// of the secondary indexes, must not exceed 100. If you project the same
    /// attribute into two different indexes, this counts as two distinct
    /// attributes when determining the total. This limit only applies when you
    /// specify the ProjectionType of `INCLUDE`. You still can
    /// specify the ProjectionType of `ALL` to project all attributes
    /// from the source table, even if the table has more than 100
    /// attributes.
    ///
    /// * `IndexSizeBytes` - Represents the total size of the index, in bytes.
    /// DynamoDB updates this value approximately every six hours. Recent changes
    /// might
    /// not be reflected in this value.
    ///
    /// * `ItemCount` - Represents the number of items in the index. DynamoDB
    /// updates this value approximately every six hours. Recent changes might not
    /// be
    /// reflected in this value.
    ///
    /// If the table is in the `DELETING` state, no information about indexes will
    /// be returned.
    local_secondary_indexes: ?[]const LocalSecondaryIndexDescription,

    /// Indicates one of the following consistency modes for a global table:
    ///
    /// * `EVENTUAL`: Indicates that the global table is configured for
    /// multi-Region eventual consistency (MREC).
    ///
    /// * `STRONG`: Indicates that the global table is configured for
    /// multi-Region strong consistency (MRSC).
    ///
    /// If you don't specify this field, the global table consistency mode defaults
    /// to
    /// `EVENTUAL`. For more information about global tables consistency modes,
    /// see [
    /// Consistency
    /// modes](https://docs.aws.amazon.com/V2globaltables_HowItWorks.html#V2globaltables_HowItWorks.consistency-modes) in DynamoDB developer guide.
    multi_region_consistency: ?MultiRegionConsistency,

    /// The maximum number of read and write units for the specified on-demand
    /// table. If you
    /// use this parameter, you must specify `MaxReadRequestUnits`,
    /// `MaxWriteRequestUnits`, or both.
    on_demand_throughput: ?OnDemandThroughput,

    /// The provisioned throughput settings for the table, consisting of read and
    /// write
    /// capacity units, along with data about increases and decreases.
    provisioned_throughput: ?ProvisionedThroughputDescription,

    /// Represents replicas of the table.
    replicas: ?[]const ReplicaDescription,

    /// Contains details for the restore.
    restore_summary: ?RestoreSummary,

    /// The description of the server-side encryption status on the specified table.
    sse_description: ?SSEDescription,

    /// The current DynamoDB Streams configuration for the table.
    stream_specification: ?StreamSpecification,

    /// The Amazon Resource Name (ARN) that uniquely identifies the table.
    table_arn: ?[]const u8,

    /// Contains details of the table class.
    table_class_summary: ?TableClassSummary,

    /// Unique identifier for the table for which the backup was created.
    table_id: ?[]const u8,

    /// The name of the table.
    table_name: ?[]const u8,

    /// The total size of the specified table, in bytes. DynamoDB updates this value
    /// approximately every six hours. Recent changes might not be reflected in this
    /// value.
    table_size_bytes: ?i64,

    /// The current state of the table:
    ///
    /// * `CREATING` - The table is being created.
    ///
    /// * `UPDATING` - The table/index configuration is being updated. The
    /// table/index remains available for data operations when
    /// `UPDATING`.
    ///
    /// * `DELETING` - The table is being deleted.
    ///
    /// * `ACTIVE` - The table is ready for use.
    ///
    /// * `INACCESSIBLE_ENCRYPTION_CREDENTIALS` - The KMS key
    /// used to encrypt the table in inaccessible. Table operations may fail due to
    /// failure to use the KMS key. DynamoDB will initiate the
    /// table archival process when a table's KMS key remains
    /// inaccessible for more than seven days.
    ///
    /// * `ARCHIVING` - The table is being archived. Operations are not allowed
    /// until archival is complete.
    ///
    /// * `ARCHIVED` - The table has been archived. See the ArchivalReason for
    /// more information.
    table_status: ?TableStatus,

    /// Describes the warm throughput value of the base table.
    warm_throughput: ?TableWarmThroughputDescription,

    pub const json_field_names = .{
        .archival_summary = "ArchivalSummary",
        .attribute_definitions = "AttributeDefinitions",
        .billing_mode_summary = "BillingModeSummary",
        .creation_date_time = "CreationDateTime",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .global_table_settings_replication_mode = "GlobalTableSettingsReplicationMode",
        .global_table_version = "GlobalTableVersion",
        .global_table_witnesses = "GlobalTableWitnesses",
        .item_count = "ItemCount",
        .key_schema = "KeySchema",
        .latest_stream_arn = "LatestStreamArn",
        .latest_stream_label = "LatestStreamLabel",
        .local_secondary_indexes = "LocalSecondaryIndexes",
        .multi_region_consistency = "MultiRegionConsistency",
        .on_demand_throughput = "OnDemandThroughput",
        .provisioned_throughput = "ProvisionedThroughput",
        .replicas = "Replicas",
        .restore_summary = "RestoreSummary",
        .sse_description = "SSEDescription",
        .stream_specification = "StreamSpecification",
        .table_arn = "TableArn",
        .table_class_summary = "TableClassSummary",
        .table_id = "TableId",
        .table_name = "TableName",
        .table_size_bytes = "TableSizeBytes",
        .table_status = "TableStatus",
        .warm_throughput = "WarmThroughput",
    };
};
