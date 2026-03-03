const HlsMediaStoreStorageClass = @import("hls_media_store_storage_class.zig").HlsMediaStoreStorageClass;

/// Hls Media Store Settings
pub const HlsMediaStoreSettings = struct {
    /// Number of seconds to wait before retrying connection to the CDN if the
    /// connection is lost.
    connection_retry_interval: ?i32 = null,

    /// Size in seconds of file cache for streaming outputs.
    filecache_duration: ?i32 = null,

    /// When set to temporal, output files are stored in non-persistent memory for
    /// faster reading and writing.
    media_store_storage_class: ?HlsMediaStoreStorageClass = null,

    /// Number of retry attempts that will be made before the Live Event is put into
    /// an error state. Applies only if the CDN destination URI begins with "s3" or
    /// "mediastore". For other URIs, the value is always 3.
    num_retries: ?i32 = null,

    /// If a streaming output fails, number of seconds to wait until a restart is
    /// initiated. A value of 0 means never restart.
    restart_delay: ?i32 = null,

    pub const json_field_names = .{
        .connection_retry_interval = "ConnectionRetryInterval",
        .filecache_duration = "FilecacheDuration",
        .media_store_storage_class = "MediaStoreStorageClass",
        .num_retries = "NumRetries",
        .restart_delay = "RestartDelay",
    };
};
