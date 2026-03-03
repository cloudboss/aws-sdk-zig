/// Information about the provisioned throughput for the table or for a global
/// secondary
/// index.
pub const AwsDynamoDbTableProvisionedThroughput = struct {
    /// Indicates when the provisioned throughput was last decreased.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_decrease_date_time: ?[]const u8 = null,

    /// Indicates when the provisioned throughput was last increased.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_increase_date_time: ?[]const u8 = null,

    /// The number of times during the current UTC calendar day that the provisioned
    /// throughput
    /// was decreased.
    number_of_decreases_today: ?i32 = null,

    /// The maximum number of strongly consistent reads consumed per second before
    /// DynamoDB
    /// returns a `ThrottlingException`.
    read_capacity_units: ?i32 = null,

    /// The maximum number of writes consumed per second before DynamoDB returns a
    /// `ThrottlingException`.
    write_capacity_units: ?i32 = null,

    pub const json_field_names = .{
        .last_decrease_date_time = "LastDecreaseDateTime",
        .last_increase_date_time = "LastIncreaseDateTime",
        .number_of_decreases_today = "NumberOfDecreasesToday",
        .read_capacity_units = "ReadCapacityUnits",
        .write_capacity_units = "WriteCapacityUnits",
    };
};
