/// Configuration for backing up centralized metrics data to a secondary region.
pub const MetricsBackupConfiguration = struct {
    /// Metrics specific backup destination region within the primary destination
    /// account to which metrics data should be centralized.
    region: []const u8,

    pub const json_field_names = .{
        .region = "Region",
    };
};
