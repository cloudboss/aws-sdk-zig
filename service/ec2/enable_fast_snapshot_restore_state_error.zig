/// Describes an error that occurred when enabling fast snapshot restores.
pub const EnableFastSnapshotRestoreStateError = struct {
    /// The error code.
    code: ?[]const u8,

    /// The error message.
    message: ?[]const u8,
};
