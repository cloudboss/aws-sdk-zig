const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const Projection = @import("projection.zig").Projection;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;
const WarmThroughput = @import("warm_throughput.zig").WarmThroughput;

/// Represents the properties of a global secondary index.
pub const GlobalSecondaryIndex = struct {
    /// The name of the global secondary index. The name must be unique among all
    /// other
    /// indexes on this table.
    index_name: []const u8,

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
    /// attribute*. The term "hash attribute" derives from DynamoDB's usage of
    /// an internal hash function to evenly distribute data items across partitions,
    /// based
    /// on their partition key values.
    ///
    /// The sort key of an item is also known as its *range attribute*.
    /// The term "range attribute" derives from the way DynamoDB stores items with
    /// the same
    /// partition key physically close together, in sorted order by the sort key
    /// value.
    key_schema: []const KeySchemaElement,

    /// The maximum number of read and write units for the specified global
    /// secondary index.
    /// If you use this parameter, you must specify `MaxReadRequestUnits`,
    /// `MaxWriteRequestUnits`, or both. You must use either
    /// `OnDemandThroughput` or `ProvisionedThroughput` based on your
    /// table's capacity mode.
    on_demand_throughput: ?OnDemandThroughput,

    /// Represents attributes that are copied (projected) from the table into the
    /// global
    /// secondary index. These are in addition to the primary key attributes and
    /// index key
    /// attributes, which are automatically projected.
    projection: Projection,

    /// Represents the provisioned throughput settings for the specified global
    /// secondary
    /// index. You must use either `OnDemandThroughput` or
    /// `ProvisionedThroughput` based on your table's capacity mode.
    ///
    /// For current minimum and maximum provisioned throughput values, see [Service,
    /// Account, and Table
    /// Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    provisioned_throughput: ?ProvisionedThroughput,

    /// Represents the warm throughput value (in read units per second and write
    /// units per
    /// second) for the specified secondary index. If you use this parameter, you
    /// must specify
    /// `ReadUnitsPerSecond`, `WriteUnitsPerSecond`, or both.
    warm_throughput: ?WarmThroughput,
};
