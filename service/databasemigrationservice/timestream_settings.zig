/// Provides information that defines an Amazon Timestream endpoint.
pub const TimestreamSettings = struct {
    /// Set this attribute to `true` to specify that DMS only applies inserts and
    /// updates, and not deletes. Amazon Timestream does not allow deleting records,
    /// so if this
    /// value is `false`, DMS nulls out the corresponding record in the Timestream
    /// database rather than deleting it.
    cdc_inserts_and_updates: ?bool,

    /// Database name for the endpoint.
    database_name: []const u8,

    /// Set this attribute to `true` to enable memory store writes. When this value
    /// is `false`, DMS does not write records that are older in days than the value
    /// specified in `MagneticDuration`, because Amazon Timestream does not allow
    /// memory
    /// writes by default. For more information, see
    /// [Storage](https://docs.aws.amazon.com/timestream/latest/developerguide/storage.html) in the [Amazon Timestream Developer
    /// Guide](https://docs.aws.amazon.com/timestream/latest/developerguide/).
    enable_magnetic_store_writes: ?bool,

    /// Set this attribute to specify the default magnetic duration applied to the
    /// Amazon
    /// Timestream tables in days. This is the number of days that records remain in
    /// magnetic store
    /// before being discarded. For more information, see
    /// [Storage](https://docs.aws.amazon.com/timestream/latest/developerguide/storage.html) in the [Amazon Timestream Developer
    /// Guide](https://docs.aws.amazon.com/timestream/latest/developerguide/).
    magnetic_duration: i32,

    /// Set this attribute to specify the length of time to store all of the tables
    /// in memory
    /// that are migrated into Amazon Timestream from the source database. Time is
    /// measured in
    /// units of hours. When Timestream data comes in, it first resides in memory
    /// for the specified
    /// duration, which allows quick access to it.
    memory_duration: i32,

    pub const json_field_names = .{
        .cdc_inserts_and_updates = "CdcInsertsAndUpdates",
        .database_name = "DatabaseName",
        .enable_magnetic_store_writes = "EnableMagneticStoreWrites",
        .magnetic_duration = "MagneticDuration",
        .memory_duration = "MemoryDuration",
    };
};
