/// Specifies the warm throughput settings for a table. Pre-warming a table by
/// specifying warm throughput pre-provisions read and write capacity units to
/// help avoid capacity exceeded exceptions and reduce latency when your table
/// starts receiving traffic.
///
/// For more information about pre-warming in Amazon Keyspaces, see [Pre-warm a
/// table in Amazon
/// Keyspaces](https://docs.aws.amazon.com/keyspaces/latest/devguide/warm-throughput.html) in the *Amazon Keyspaces Developer Guide*.
pub const WarmThroughputSpecification = struct {
    /// The number of read capacity units per second to pre-warm the table for read
    /// capacity throughput. The minimum value is 1.
    read_units_per_second: ?i64 = null,

    /// The number of write capacity units per second to pre-warm the table for
    /// write capacity throughput. The minimum value is 1.
    write_units_per_second: ?i64 = null,

    pub const json_field_names = .{
        .read_units_per_second = "readUnitsPerSecond",
        .write_units_per_second = "writeUnitsPerSecond",
    };
};
