/// Represents the amount of provisioned throughput capacity consumed on a table
/// or an
/// index.
pub const Capacity = struct {
    /// The total number of capacity units consumed on a table or an index.
    capacity_units: ?f64 = null,

    /// The total number of read capacity units consumed on a table or an index.
    read_capacity_units: ?f64 = null,

    /// The total number of write capacity units consumed on a table or an index.
    write_capacity_units: ?f64 = null,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .read_capacity_units = "ReadCapacityUnits",
        .write_capacity_units = "WriteCapacityUnits",
    };
};
