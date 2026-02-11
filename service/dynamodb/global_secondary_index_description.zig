const IndexStatus = @import("index_status.zig").IndexStatus;
const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const Projection = @import("projection.zig").Projection;
const ProvisionedThroughputDescription = @import("provisioned_throughput_description.zig").ProvisionedThroughputDescription;
const GlobalSecondaryIndexWarmThroughputDescription = @import("global_secondary_index_warm_throughput_description.zig").GlobalSecondaryIndexWarmThroughputDescription;

/// Represents the properties of a global secondary index.
pub const GlobalSecondaryIndexDescription = struct {
    /// Indicates whether the index is currently backfilling. *Backfilling*
    /// is the process of reading items from the table and determining whether they
    /// can be added
    /// to the index. (Not all items will qualify: For example, a partition key
    /// cannot have any
    /// duplicate values.) If an item can be added to the index, DynamoDB will do
    /// so. After all
    /// items have been processed, the backfilling operation is complete and
    /// `Backfilling` is false.
    ///
    /// You can delete an index that is being created during the `Backfilling`
    /// phase when `IndexStatus` is set to CREATING and `Backfilling` is
    /// true. You can't delete the index that is being created when `IndexStatus` is
    /// set to CREATING and `Backfilling` is false.
    ///
    /// **Note:**
    ///
    /// For indexes that were created during a `CreateTable` operation, the
    /// `Backfilling` attribute does not appear in the
    /// `DescribeTable` output.
    backfilling: ?bool,

    /// The Amazon Resource Name (ARN) that uniquely identifies the index.
    index_arn: ?[]const u8,

    /// The name of the global secondary index.
    index_name: ?[]const u8,

    /// The total size of the specified index, in bytes. DynamoDB updates this value
    /// approximately every six hours. Recent changes might not be reflected in this
    /// value.
    index_size_bytes: ?i64,

    /// The current state of the global secondary index:
    ///
    /// * `CREATING` - The index is being created.
    ///
    /// * `UPDATING` - The index is being updated.
    ///
    /// * `DELETING` - The index is being deleted.
    ///
    /// * `ACTIVE` - The index is ready for use.
    index_status: ?IndexStatus,

    /// The number of items in the specified index. DynamoDB updates this value
    /// approximately
    /// every six hours. Recent changes might not be reflected in this value.
    item_count: ?i64,

    /// The complete key schema for a global secondary index, which consists of one
    /// or more
    /// pairs of attribute names and key types:
    ///
    /// * `HASH` - partition key
    ///
    /// * `RANGE` - sort key
    ///
    /// **Note:**
    ///
    /// The partition key of an item is also known as its *hash
    /// attribute*. The term "hash attribute" derives from DynamoDB's usage of an
    /// internal hash function to evenly distribute data items across
    /// partitions, based on their partition key values.
    ///
    /// The sort key of an item is also known as its *range attribute*.
    /// The term "range attribute" derives from the way DynamoDB stores items with
    /// the same partition key physically close together, in sorted order by the
    /// sort key
    /// value.
    key_schema: ?[]const KeySchemaElement,

    /// The maximum number of read and write units for the specified global
    /// secondary index.
    /// If you use this parameter, you must specify `MaxReadRequestUnits`,
    /// `MaxWriteRequestUnits`, or both.
    on_demand_throughput: ?OnDemandThroughput,

    /// Represents attributes that are copied (projected) from the table into the
    /// global
    /// secondary index. These are in addition to the primary key attributes and
    /// index key
    /// attributes, which are automatically projected.
    projection: ?Projection,

    /// Represents the provisioned throughput settings for the specified global
    /// secondary
    /// index.
    ///
    /// For current minimum and maximum provisioned throughput values, see [Service,
    /// Account, and Table
    /// Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    provisioned_throughput: ?ProvisionedThroughputDescription,

    /// Represents the warm throughput value (in read units per second and write
    /// units per
    /// second) for the specified secondary index.
    warm_throughput: ?GlobalSecondaryIndexWarmThroughputDescription,

    pub const json_field_names = .{
        .backfilling = "Backfilling",
        .index_arn = "IndexArn",
        .index_name = "IndexName",
        .index_size_bytes = "IndexSizeBytes",
        .index_status = "IndexStatus",
        .item_count = "ItemCount",
        .key_schema = "KeySchema",
        .on_demand_throughput = "OnDemandThroughput",
        .projection = "Projection",
        .provisioned_throughput = "ProvisionedThroughput",
        .warm_throughput = "WarmThroughput",
    };
};
