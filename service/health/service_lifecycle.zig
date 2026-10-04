const LifecycleEvent = @import("lifecycle_event.zig").LifecycleEvent;

/// Contains lifecycle information for an Amazon Web Services service version,
/// including lifecycle events and version recommendations.
pub const ServiceLifecycle = struct {
    /// The list of lifecycle events for this service version.
    lifecycle_events: ?[]const LifecycleEvent = null,

    /// The recommended version to upgrade to.
    recommended_version: ?[]const u8 = null,

    /// The name of the Amazon Web Services service.
    service: ?[]const u8 = null,

    /// A human-readable title for the lifecycle entry.
    title: ?[]const u8 = null,

    /// The version of the service.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle_events = "lifecycleEvents",
        .recommended_version = "recommendedVersion",
        .service = "service",
        .title = "title",
        .version = "version",
    };
};
