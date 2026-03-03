/// Export errors data.
pub const ExportErrorData = struct {
    /// Export errors data raw error.
    raw_error: ?[]const u8 = null,

    pub const json_field_names = .{
        .raw_error = "rawError",
    };
};
