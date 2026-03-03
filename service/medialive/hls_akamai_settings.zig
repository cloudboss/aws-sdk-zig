const HlsAkamaiHttpTransferMode = @import("hls_akamai_http_transfer_mode.zig").HlsAkamaiHttpTransferMode;

/// Hls Akamai Settings
pub const HlsAkamaiSettings = struct {
    /// Number of seconds to wait before retrying connection to the CDN if the
    /// connection is lost.
    connection_retry_interval: ?i32 = null,

    /// Size in seconds of file cache for streaming outputs.
    filecache_duration: ?i32 = null,

    /// Specify whether or not to use chunked transfer encoding to Akamai. User
    /// should contact Akamai to enable this feature.
    http_transfer_mode: ?HlsAkamaiHttpTransferMode = null,

    /// Number of retry attempts that will be made before the Live Event is put into
    /// an error state. Applies only if the CDN destination URI begins with "s3" or
    /// "mediastore". For other URIs, the value is always 3.
    num_retries: ?i32 = null,

    /// If a streaming output fails, number of seconds to wait until a restart is
    /// initiated. A value of 0 means never restart.
    restart_delay: ?i32 = null,

    /// Salt for authenticated Akamai.
    salt: ?[]const u8 = null,

    /// Token parameter for authenticated akamai. If not specified, _gda_ is used.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_retry_interval = "ConnectionRetryInterval",
        .filecache_duration = "FilecacheDuration",
        .http_transfer_mode = "HttpTransferMode",
        .num_retries = "NumRetries",
        .restart_delay = "RestartDelay",
        .salt = "Salt",
        .token = "Token",
    };
};
