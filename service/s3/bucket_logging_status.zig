const LoggingEnabled = @import("logging_enabled.zig").LoggingEnabled;

/// Container for logging status information.
pub const BucketLoggingStatus = struct {
    logging_enabled: ?LoggingEnabled = null,
};
