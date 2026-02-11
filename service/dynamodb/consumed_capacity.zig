const Capacity = @import("capacity.zig").Capacity;

/// The capacity units consumed by an operation. The data returned includes the
/// total
/// provisioned throughput consumed, along with statistics for the table and any
/// indexes
/// involved in the operation. `ConsumedCapacity` is only returned if the
/// request
/// asked for it. For more information, see [Provisioned capacity
/// mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html) in the *Amazon DynamoDB Developer
/// Guide*.
pub const ConsumedCapacity = struct {
    /// The total number of capacity units consumed by the operation.
    capacity_units: ?f64,

    /// The amount of throughput consumed on each global index affected by the
    /// operation.
    global_secondary_indexes: ?[]const u8,

    /// The amount of throughput consumed on each local index affected by the
    /// operation.
    local_secondary_indexes: ?[]const u8,

    /// The total number of read capacity units consumed by the operation.
    read_capacity_units: ?f64,

    /// The amount of throughput consumed on the table affected by the operation.
    table: ?Capacity,

    /// The name of the table that was affected by the operation. If you had
    /// specified the
    /// Amazon Resource Name (ARN) of a table in the input, you'll see the table ARN
    /// in the response.
    table_name: ?[]const u8,

    /// The total number of write capacity units consumed by the operation.
    write_capacity_units: ?f64,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .local_secondary_indexes = "LocalSecondaryIndexes",
        .read_capacity_units = "ReadCapacityUnits",
        .table = "Table",
        .table_name = "TableName",
        .write_capacity_units = "WriteCapacityUnits",
    };
};
