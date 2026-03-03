const LoggingFormat = @import("logging_format.zig").LoggingFormat;

/// An object that represents an access log file.
pub const FileAccessLog = struct {
    /// The specified format for the logs. The format is either `json_format` or
    /// `text_format`.
    format: ?LoggingFormat = null,

    /// The file path to write access logs to. You can use `/dev/stdout` to send
    /// access logs to standard out and configure your Envoy container to use a log
    /// driver, such as
    /// `awslogs`, to export the access logs to a log storage service such as Amazon
    /// CloudWatch Logs. You can also specify a path in the Envoy container's file
    /// system to write
    /// the files to disk.
    ///
    /// The Envoy process must have write permissions to the path that you specify
    /// here.
    /// Otherwise, Envoy fails to bootstrap properly.
    path: []const u8,

    pub const json_field_names = .{
        .format = "format",
        .path = "path",
    };
};
