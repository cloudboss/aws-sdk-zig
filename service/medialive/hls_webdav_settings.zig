const HlsWebdavHttpTransferMode = @import("hls_webdav_http_transfer_mode.zig").HlsWebdavHttpTransferMode;

/// Hls Webdav Settings
pub const HlsWebdavSettings = struct {
    /// Number of seconds to wait before retrying connection to the CDN if the
    /// connection is lost.
    connection_retry_interval: ?i32,

    /// Size in seconds of file cache for streaming outputs.
    filecache_duration: ?i32,

    /// Specify whether or not to use chunked transfer encoding to WebDAV.
    http_transfer_mode: ?HlsWebdavHttpTransferMode,

    /// Number of retry attempts that will be made before the Live Event is put into
    /// an error state. Applies only if the CDN destination URI begins with "s3" or
    /// "mediastore". For other URIs, the value is always 3.
    num_retries: ?i32,

    /// If a streaming output fails, number of seconds to wait until a restart is
    /// initiated. A value of 0 means never restart.
    restart_delay: ?i32,

    pub const json_field_names = .{
        .connection_retry_interval = "ConnectionRetryInterval",
        .filecache_duration = "FilecacheDuration",
        .http_transfer_mode = "HttpTransferMode",
        .num_retries = "NumRetries",
        .restart_delay = "RestartDelay",
    };
};
