const LogLevel = @import("log_level.zig").LogLevel;

/// The different configurations for runtime logs.
pub const RuntimeLogConfigurations = struct {
    /// Configuration to enable or disable deleting of runtime logs in the device
    /// once uploaded to the cloud.
    delete_local_store_after_upload: ?bool,

    /// Configuration to set the maximum bytes of runtime logs that can be stored on
    /// the device before the oldest logs are deleted or overwritten.
    local_store_file_rotation_max_bytes: ?i32,

    /// Configuration to set the maximum number of runtime log files that can be
    /// stored on the device before the oldest files are deleted or overwritten.
    local_store_file_rotation_max_files: ?i32,

    /// Configuration of where to store runtime logs in the device.
    local_store_location: ?[]const u8,

    /// The different log levels available for configuration.
    log_flush_level: ?LogLevel,

    /// The different log levels available for configuration.
    log_level: ?LogLevel,

    /// Configuration to enable or disable uploading of runtime logs to the cloud.
    upload_log: ?bool,

    /// Configuration to set the time interval in minutes between each batch of
    /// runtime logs that the device uploads to the cloud.
    upload_period_minutes: ?i32,

    pub const json_field_names = .{
        .delete_local_store_after_upload = "DeleteLocalStoreAfterUpload",
        .local_store_file_rotation_max_bytes = "LocalStoreFileRotationMaxBytes",
        .local_store_file_rotation_max_files = "LocalStoreFileRotationMaxFiles",
        .local_store_location = "LocalStoreLocation",
        .log_flush_level = "LogFlushLevel",
        .log_level = "LogLevel",
        .upload_log = "UploadLog",
        .upload_period_minutes = "UploadPeriodMinutes",
    };
};
