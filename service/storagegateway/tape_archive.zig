/// Represents a virtual tape that is archived in the virtual tape shelf (VTS).
pub const TapeArchive = struct {
    /// The time that the archiving of the virtual tape was completed.
    ///
    /// The default timestamp format is in the ISO8601 extended
    /// YYYY-MM-DD'T'HH:MM:SS'Z'
    /// format.
    completion_time: ?i64 = null,

    kms_key: ?[]const u8 = null,

    /// The time that the tape entered the custom tape pool.
    ///
    /// The default timestamp format is in the ISO8601 extended
    /// YYYY-MM-DD'T'HH:MM:SS'Z'
    /// format.
    pool_entry_date: ?i64 = null,

    /// The ID of the pool that was used to archive the tape. The tapes in this pool
    /// are
    /// archived in the S3 storage class that is associated with the pool.
    pool_id: ?[]const u8 = null,

    /// If the archived tape is subject to tape retention lock, the date that the
    /// archived tape
    /// started being retained.
    retention_start_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the tape gateway that the virtual tape is
    /// being
    /// retrieved to.
    ///
    /// The virtual tape is retrieved from the virtual tape shelf (VTS).
    retrieved_to: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an archived virtual tape.
    tape_arn: ?[]const u8 = null,

    /// The barcode that identifies the archived virtual tape.
    tape_barcode: ?[]const u8 = null,

    /// The date the virtual tape was created.
    tape_created_date: ?i64 = null,

    /// The size, in bytes, of the archived virtual tape.
    tape_size_in_bytes: ?i64 = null,

    /// The current state of the archived virtual tape.
    tape_status: ?[]const u8 = null,

    /// The size, in bytes, of data stored on the virtual tape.
    ///
    /// This value is not available for tapes created prior to May 13, 2015.
    tape_used_in_bytes: ?i64 = null,

    /// Set to `true` if the archived tape is stored as write-once-read-many
    /// (WORM).
    worm: bool = false,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .kms_key = "KMSKey",
        .pool_entry_date = "PoolEntryDate",
        .pool_id = "PoolId",
        .retention_start_date = "RetentionStartDate",
        .retrieved_to = "RetrievedTo",
        .tape_arn = "TapeARN",
        .tape_barcode = "TapeBarcode",
        .tape_created_date = "TapeCreatedDate",
        .tape_size_in_bytes = "TapeSizeInBytes",
        .tape_status = "TapeStatus",
        .tape_used_in_bytes = "TapeUsedInBytes",
        .worm = "Worm",
    };
};
