/// Describes a virtual tape.
pub const TapeInfo = struct {
    /// The Amazon Resource Name (ARN) of the gateway. Use the ListGateways
    /// operation to return a list of gateways for your account and Amazon Web
    /// Services Region.
    gateway_arn: ?[]const u8,

    /// The date that the tape entered the custom tape pool with tape retention lock
    /// enabled.
    pool_entry_date: ?i64,

    /// The ID of the pool that you want to add your tape to for archiving. The tape
    /// in this
    /// pool is archived in the S3 storage class that is associated with the pool.
    /// When you use
    /// your backup application to eject the tape, the tape is archived directly
    /// into the storage
    /// class (S3 Glacier or S3 Glacier Deep Archive) that corresponds to the pool.
    pool_id: ?[]const u8,

    /// The date that the tape became subject to tape retention lock.
    retention_start_date: ?i64,

    /// The Amazon Resource Name (ARN) of a virtual tape.
    tape_arn: ?[]const u8,

    /// The barcode that identifies a specific virtual tape.
    tape_barcode: ?[]const u8,

    /// The size, in bytes, of a virtual tape.
    tape_size_in_bytes: ?i64,

    /// The status of the tape.
    tape_status: ?[]const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .pool_entry_date = "PoolEntryDate",
        .pool_id = "PoolId",
        .retention_start_date = "RetentionStartDate",
        .tape_arn = "TapeARN",
        .tape_barcode = "TapeBarcode",
        .tape_size_in_bytes = "TapeSizeInBytes",
        .tape_status = "TapeStatus",
    };
};
