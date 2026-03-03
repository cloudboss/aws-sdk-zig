const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;

/// The read/write throughput capacity mode for a table. The options are:
///
/// * `throughputMode:PAY_PER_REQUEST` and
/// * `throughputMode:PROVISIONED`.
///
/// For more information, see [Read/write capacity
/// modes](https://docs.aws.amazon.com/keyspaces/latest/devguide/ReadWriteCapacityMode.html) in the *Amazon Keyspaces Developer Guide*.
pub const CapacitySpecificationSummary = struct {
    /// The timestamp of the last operation that changed the provisioned throughput
    /// capacity of a table.
    last_update_to_pay_per_request_timestamp: ?i64 = null,

    /// The throughput capacity specified for `read` operations defined in `read
    /// capacity units` `(RCUs)`.
    read_capacity_units: ?i64 = null,

    /// The read/write throughput capacity mode for a table. The options are:
    ///
    /// * `throughputMode:PAY_PER_REQUEST` and
    /// * `throughputMode:PROVISIONED` - Provisioned capacity mode requires
    ///   `readCapacityUnits` and `writeCapacityUnits` as input.
    ///
    /// The default is `throughput_mode:PAY_PER_REQUEST`.
    ///
    /// For more information, see [Read/write capacity
    /// modes](https://docs.aws.amazon.com/keyspaces/latest/devguide/ReadWriteCapacityMode.html) in the *Amazon Keyspaces Developer Guide*.
    throughput_mode: ThroughputMode,

    /// The throughput capacity specified for `write` operations defined in `write
    /// capacity units` `(WCUs)`.
    write_capacity_units: ?i64 = null,

    pub const json_field_names = .{
        .last_update_to_pay_per_request_timestamp = "lastUpdateToPayPerRequestTimestamp",
        .read_capacity_units = "readCapacityUnits",
        .throughput_mode = "throughputMode",
        .write_capacity_units = "writeCapacityUnits",
    };
};
