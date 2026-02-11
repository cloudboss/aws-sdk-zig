/// Represents the provisioned throughput settings for the specified global
/// secondary
/// index. You must use `ProvisionedThroughput` or
/// `OnDemandThroughput` based on your table’s capacity mode.
///
/// For current minimum and maximum provisioned throughput values, see [Service,
/// Account, and Table
/// Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer
/// Guide*.
pub const ProvisionedThroughput = struct {
    /// The maximum number of strongly consistent reads consumed per second before
    /// DynamoDB
    /// returns a `ThrottlingException`. For more information, see [Specifying
    /// Read and Write
    /// Requirements](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughput.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    ///
    /// If read/write capacity mode is `PAY_PER_REQUEST` the value is set to
    /// 0.
    read_capacity_units: i64,

    /// The maximum number of writes consumed per second before DynamoDB returns a
    /// `ThrottlingException`. For more information, see [Specifying
    /// Read and Write
    /// Requirements](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ProvisionedThroughput.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    ///
    /// If read/write capacity mode is `PAY_PER_REQUEST` the value is set to
    /// 0.
    write_capacity_units: i64,

    pub const json_field_names = .{
        .read_capacity_units = "ReadCapacityUnits",
        .write_capacity_units = "WriteCapacityUnits",
    };
};
