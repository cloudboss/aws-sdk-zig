const BillingMode = @import("billing_mode.zig").BillingMode;
const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;

/// Contains the details of the table when the backup was created.
pub const SourceTableDetails = struct {
    /// Controls how you are charged for read and write throughput and how you
    /// manage
    /// capacity. This setting can be changed later.
    ///
    /// * `PROVISIONED` - Sets the read/write capacity mode to
    /// `PROVISIONED`. We recommend using `PROVISIONED` for
    /// predictable workloads.
    ///
    /// * `PAY_PER_REQUEST` - Sets the read/write capacity mode to
    /// `PAY_PER_REQUEST`. We recommend using
    /// `PAY_PER_REQUEST` for unpredictable workloads.
    billing_mode: ?BillingMode = null,

    /// Number of items in the table. Note that this is an approximate value.
    item_count: ?i64 = null,

    /// Schema of the table.
    key_schema: []const KeySchemaElement,

    on_demand_throughput: ?OnDemandThroughput = null,

    /// Read IOPs and Write IOPS on the table when the backup was created.
    provisioned_throughput: ProvisionedThroughput,

    /// ARN of the table for which backup was created.
    table_arn: ?[]const u8 = null,

    /// Time when the source table was created.
    table_creation_date_time: i64,

    /// Unique identifier for the table for which the backup was created.
    table_id: []const u8,

    /// The name of the table for which the backup was created.
    table_name: []const u8,

    /// Size of the table in bytes. Note that this is an approximate value.
    table_size_bytes: ?i64 = null,

    pub const json_field_names = .{
        .billing_mode = "BillingMode",
        .item_count = "ItemCount",
        .key_schema = "KeySchema",
        .on_demand_throughput = "OnDemandThroughput",
        .provisioned_throughput = "ProvisionedThroughput",
        .table_arn = "TableArn",
        .table_creation_date_time = "TableCreationDateTime",
        .table_id = "TableId",
        .table_name = "TableName",
        .table_size_bytes = "TableSizeBytes",
    };
};
