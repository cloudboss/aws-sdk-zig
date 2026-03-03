const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const Projection = @import("projection.zig").Projection;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;
const WarmThroughput = @import("warm_throughput.zig").WarmThroughput;

/// Represents a new global secondary index to be added to an existing table.
pub const CreateGlobalSecondaryIndexAction = struct {
    /// The name of the global secondary index to be created.
    index_name: []const u8,

    /// The key schema for the global secondary index.
    /// Global secondary index supports up to 4 partition and up to 4 sort keys.
    key_schema: []const KeySchemaElement,

    /// The maximum number of read and write units for the global secondary index
    /// being
    /// created. If you use this parameter, you must specify `MaxReadRequestUnits`,
    /// `MaxWriteRequestUnits`, or both. You must use either `OnDemand
    /// Throughput` or `ProvisionedThroughput` based on your table's
    /// capacity mode.
    on_demand_throughput: ?OnDemandThroughput = null,

    /// Represents attributes that are copied (projected) from the table into an
    /// index. These
    /// are in addition to the primary key attributes and index key attributes,
    /// which are
    /// automatically projected.
    projection: Projection,

    /// Represents the provisioned throughput settings for the specified global
    /// secondary
    /// index.
    ///
    /// For current minimum and maximum provisioned throughput values, see [Service,
    /// Account, and Table
    /// Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    provisioned_throughput: ?ProvisionedThroughput = null,

    /// Represents the warm throughput value (in read units per second and write
    /// units per
    /// second) when creating a secondary index.
    warm_throughput: ?WarmThroughput = null,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .key_schema = "KeySchema",
        .on_demand_throughput = "OnDemandThroughput",
        .projection = "Projection",
        .provisioned_throughput = "ProvisionedThroughput",
        .warm_throughput = "WarmThroughput",
    };
};
