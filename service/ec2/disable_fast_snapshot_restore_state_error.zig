/// Describes an error that occurred when disabling fast snapshot restores.
pub const DisableFastSnapshotRestoreStateError = struct {
    /// The error code.
    code: ?[]const u8,

    /// The error message.
    message: ?[]const u8,
};
