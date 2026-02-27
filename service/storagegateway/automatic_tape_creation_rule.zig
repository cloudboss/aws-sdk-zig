/// An automatic tape creation policy consists of automatic tape creation rules
/// where each
/// rule defines when and how to create new tapes. For more information about
/// automatic tape
/// creation, see [Creating Tapes
/// Automatically](https://docs.aws.amazon.com/storagegateway/latest/userguide/GettingStartedCreateTapes.html#CreateTapesAutomatically).
pub const AutomaticTapeCreationRule = struct {
    /// The minimum number of available virtual tapes that the gateway maintains at
    /// all times.
    /// If the number of tapes on the gateway goes below this value, the gateway
    /// creates as many
    /// new tapes as are needed to have `MinimumNumTapes` on the gateway. For more
    /// information about automatic tape creation, see [Creating Tapes
    /// Automatically](https://docs.aws.amazon.com/storagegateway/latest/userguide/GettingStartedCreateTapes.html#CreateTapesAutomatically).
    minimum_num_tapes: i32,

    /// The ID of the pool that you want to add your tape to for archiving. The tape
    /// in this
    /// pool is archived in the Amazon S3 storage class that is associated with the
    /// pool.
    /// When you use your backup application to eject the tape, the tape is archived
    /// directly into
    /// the storage class (S3 Glacier or S3 Glacier Deep Archive) that corresponds
    /// to the
    /// pool.
    pool_id: []const u8,

    /// A prefix that you append to the barcode of the virtual tape that you are
    /// creating. This
    /// prefix makes the barcode unique.
    ///
    /// The prefix must be 1-4 characters in length and must be one of the uppercase
    /// letters
    /// from A to Z.
    tape_barcode_prefix: []const u8,

    /// The size, in bytes, of the virtual tape capacity.
    tape_size_in_bytes: i64,

    /// Set to `true` to indicate that tapes are to be archived as
    /// write-once-read-many (WORM). Set to `false` when WORM is not enabled for
    /// tapes.
    worm: bool = false,

    pub const json_field_names = .{
        .minimum_num_tapes = "MinimumNumTapes",
        .pool_id = "PoolId",
        .tape_barcode_prefix = "TapeBarcodePrefix",
        .tape_size_in_bytes = "TapeSizeInBytes",
        .worm = "Worm",
    };
};
