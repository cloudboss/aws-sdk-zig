/// Represents the provisioned throughput settings for the table, consisting of
/// read and
/// write capacity units, along with data about increases and decreases.
pub const ProvisionedThroughputDescription = struct {
    /// The date and time of the last provisioned throughput decrease for this
    /// table.
    last_decrease_date_time: ?i64 = null,

    /// The date and time of the last provisioned throughput increase for this
    /// table.
    last_increase_date_time: ?i64 = null,

    /// The number of provisioned throughput decreases for this table during this
    /// UTC calendar
    /// day. For current maximums on provisioned throughput decreases, see [Service,
    /// Account, and Table
    /// Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    number_of_decreases_today: ?i64 = null,

    /// The maximum number of strongly consistent reads consumed per second before
    /// DynamoDB
    /// returns a `ThrottlingException`. Eventually consistent reads require less
    /// effort than strongly consistent reads, so a setting of 50
    /// `ReadCapacityUnits`
    /// per second provides 100 eventually consistent `ReadCapacityUnits` per
    /// second.
    read_capacity_units: ?i64 = null,

    /// The maximum number of writes consumed per second before DynamoDB returns a
    /// `ThrottlingException`.
    write_capacity_units: ?i64 = null,

    pub const json_field_names = .{
        .last_decrease_date_time = "LastDecreaseDateTime",
        .last_increase_date_time = "LastIncreaseDateTime",
        .number_of_decreases_today = "NumberOfDecreasesToday",
        .read_capacity_units = "ReadCapacityUnits",
        .write_capacity_units = "WriteCapacityUnits",
    };
};
