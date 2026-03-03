/// Provides information about why a data repository task failed. Only populated
/// when the task `Lifecycle` is set to `FAILED`.
pub const DataRepositoryTaskFailureDetails = struct {
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};
