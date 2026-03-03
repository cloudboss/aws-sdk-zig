const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;

/// Amazon Keyspaces has two read/write capacity modes for processing reads and
/// writes on your tables:
///
/// * On-demand (default)
/// * Provisioned
///
/// The read/write capacity mode that you choose controls how you are charged
/// for read and write throughput and how table throughput capacity is managed.
///
/// For more information, see [Read/write capacity
/// modes](https://docs.aws.amazon.com/keyspaces/latest/devguide/ReadWriteCapacityMode.html) in the *Amazon Keyspaces Developer Guide*.
pub const CapacitySpecification = struct {
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
        .read_capacity_units = "readCapacityUnits",
        .throughput_mode = "throughputMode",
        .write_capacity_units = "writeCapacityUnits",
    };
};
