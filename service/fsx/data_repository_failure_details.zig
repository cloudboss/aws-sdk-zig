/// Provides detailed information about the data repository if its `Lifecycle`
/// is
/// set to `MISCONFIGURED` or `FAILED`.
pub const DataRepositoryFailureDetails = struct {
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
