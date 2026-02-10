/// Describes the client-specific data.
pub const ClientData = struct {
    /// A user-defined comment about the disk upload.
    comment: ?[]const u8,

    /// The time that the disk upload ends.
    upload_end: ?i64,

    /// The size of the uploaded disk image, in GiB.
    upload_size: ?f64,

    /// The time that the disk upload starts.
    upload_start: ?i64,
};
