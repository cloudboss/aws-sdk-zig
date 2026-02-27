const LogUploadEnum = @import("log_upload_enum.zig").LogUploadEnum;
const ReconnectEnum = @import("reconnect_enum.zig").ReconnectEnum;

/// Describes an Amazon WorkSpaces client.
pub const ClientProperties = struct {
    /// Specifies whether users can upload diagnostic log files of Amazon WorkSpaces
    /// client directly to
    /// WorkSpaces to troubleshoot issues when using the WorkSpaces client.
    /// When enabled, the log files will be sent to WorkSpaces automatically and
    /// will be applied to all
    /// users in the specified directory.
    log_upload_enabled: ?LogUploadEnum,

    /// Specifies whether users can cache their credentials on the Amazon WorkSpaces
    /// client.
    /// When enabled, users can choose to reconnect to their WorkSpaces without
    /// re-entering their
    /// credentials.
    reconnect_enabled: ?ReconnectEnum,

    pub const json_field_names = .{
        .log_upload_enabled = "LogUploadEnabled",
        .reconnect_enabled = "ReconnectEnabled",
    };
};
