/// Returns information about an error state of the cluster.
pub const ErrorInfo = struct {
    /// A number describing the error programmatically.
    error_code: ?[]const u8 = null,

    /// An optional field to provide more details about the error.
    error_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_string = "ErrorString",
    };
};
