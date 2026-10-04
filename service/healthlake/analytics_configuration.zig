const AnalyticsStatus = @import("analytics_status.zig").AnalyticsStatus;

/// The analytics configuration for a data store.
pub const AnalyticsConfiguration = struct {
    /// The status of the analytics configuration.
    status: ?AnalyticsStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
