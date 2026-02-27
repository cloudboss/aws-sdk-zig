const ContinuousIntegrationScanEvent = @import("continuous_integration_scan_event.zig").ContinuousIntegrationScanEvent;

/// Configuration settings for continuous integration scans that run
/// automatically when code
/// changes are made.
pub const ContinuousIntegrationScanConfiguration = struct {
    /// The repository events that trigger continuous integration scans, such as
    /// pull requests
    /// or commits.
    supported_events: []const ContinuousIntegrationScanEvent,

    pub const json_field_names = .{
        .supported_events = "supportedEvents",
    };
};
