/// Describes a virtual tape object.
pub const Tape = struct {
    kms_key: ?[]const u8 = null,

    /// The date that the tape enters a custom tape pool.
    pool_entry_date: ?i64 = null,

    /// The ID of the pool that contains tapes that will be archived. The tapes in
    /// this pool are
    /// archived in the S3 storage class that is associated with the pool. When you
    /// use your backup
    /// application to eject the tape, the tape is archived directly into the
    /// storage class (S3
    /// Glacier or S3 Glacier Deep Archive) that corresponds to the pool.
    pool_id: ?[]const u8 = null,

    /// For archiving virtual tapes, indicates how much data remains to be uploaded
    /// before
    /// archiving is complete.
    ///
    /// Range: 0 (not started) to 100 (complete).
    progress: ?f64 = null,

    /// The date that the tape is first archived with tape retention lock enabled.
    retention_start_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the virtual tape.
    tape_arn: ?[]const u8 = null,

    /// The barcode that identifies a specific virtual tape.
    tape_barcode: ?[]const u8 = null,

    /// The date the virtual tape was created.
    tape_created_date: ?i64 = null,

    /// The size, in bytes, of the virtual tape capacity.
    tape_size_in_bytes: ?i64 = null,

    /// The current state of the virtual tape.
    tape_status: ?[]const u8 = null,

    /// The size, in bytes, of data stored on the virtual tape.
    ///
    /// This value is not available for tapes created prior to May 13, 2015.
    tape_used_in_bytes: ?i64 = null,

    /// The virtual tape library (VTL) device that the virtual tape is associated
    /// with.
    vtl_device: ?[]const u8 = null,

    /// If the tape is archived as write-once-read-many (WORM), this value is
    /// `true`.
    worm: bool = false,

    pub const json_field_names = .{
        .kms_key = "KMSKey",
        .pool_entry_date = "PoolEntryDate",
        .pool_id = "PoolId",
        .progress = "Progress",
        .retention_start_date = "RetentionStartDate",
        .tape_arn = "TapeARN",
        .tape_barcode = "TapeBarcode",
        .tape_created_date = "TapeCreatedDate",
        .tape_size_in_bytes = "TapeSizeInBytes",
        .tape_status = "TapeStatus",
        .tape_used_in_bytes = "TapeUsedInBytes",
        .vtl_device = "VTLDevice",
        .worm = "Worm",
    };
};
