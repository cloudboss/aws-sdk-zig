/// Represents the specific reason why a DynamoDB request was throttled and the
/// ARN of the impacted resource. This helps identify exactly what resource is
/// being throttled,
/// what type of operation caused it, and why the throttling occurred.
pub const ThrottlingReason = struct {
    /// The reason for throttling. The throttling reason follows a specific format:
    /// `ResourceType+OperationType+LimitType`:
    ///
    /// * Resource Type (What is being throttled): Table or Index
    ///
    /// * Operation Type (What kind of operation): Read or Write
    ///
    /// * Limit Type (Why the throttling occurred):
    ///
    /// * `ProvisionedThroughputExceeded`: The request rate is
    /// exceeding the [provisioned throughput
    /// capacity](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html) (read or write capacity
    /// units) configured for a table or a global secondary index (GSI) in
    /// provisioned capacity mode.
    ///
    /// * `AccountLimitExceeded`: The request rate has caused a table
    /// or global secondary index (GSI) in on-demand mode to exceed the [per-table
    /// account-level service
    /// quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ServiceQuotas.html#default-limits-throughput) for read/write
    /// throughput in the current Amazon Web Services Region.
    ///
    /// * `KeyRangeThroughputExceeded`: The request rate directed at
    /// a specific partition key value has exceeded the [internal partition-level
    /// throughput
    /// limits](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-partition-key-design.html), indicating
    /// uneven access patterns across the table's or GSI's key space.
    ///
    /// * `MaxOnDemandThroughputExceeded`: The request rate has
    /// exceeded the [configured maximum throughput
    /// limits](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/on-demand-capacity-mode-max-throughput.html) set for a table or
    /// index in on-demand capacity mode.
    ///
    /// Examples of complete throttling reasons:
    ///
    /// * TableReadProvisionedThroughputExceeded
    ///
    /// * IndexWriteAccountLimitExceeded
    ///
    /// This helps identify exactly what resource is being throttled, what type of
    /// operation
    /// caused it, and why the throttling occurred.
    reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the DynamoDB table or index that
    /// experienced the
    /// throttling event.
    resource: ?[]const u8 = null,

    pub const json_field_names = .{
        .reason = "reason",
        .resource = "resource",
    };
};
