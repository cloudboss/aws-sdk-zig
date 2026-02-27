/// If backup creation fails, this structure contains the details of that
/// failure.
pub const BackupFailureDetails = struct {
    /// A message describing the backup-creation failure.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
