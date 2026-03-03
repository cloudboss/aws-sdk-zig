/// Describes a recovery point.
pub const TapeRecoveryPointInfo = struct {
    /// The Amazon Resource Name (ARN) of the virtual tape.
    tape_arn: ?[]const u8 = null,

    /// The time when the point-in-time view of the virtual tape was replicated for
    /// later
    /// recovery.
    ///
    /// The default timestamp format of the tape recovery point time is in the
    /// ISO8601 extended
    /// YYYY-MM-DD'T'HH:MM:SS'Z' format.
    tape_recovery_point_time: ?i64 = null,

    /// The size, in bytes, of the virtual tapes to recover.
    tape_size_in_bytes: ?i64 = null,

    /// The status of the virtual tapes.
    tape_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .tape_arn = "TapeARN",
        .tape_recovery_point_time = "TapeRecoveryPointTime",
        .tape_size_in_bytes = "TapeSizeInBytes",
        .tape_status = "TapeStatus",
    };
};
