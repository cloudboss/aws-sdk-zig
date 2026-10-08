const AutoDetectionConfiguration = @import("auto_detection_configuration.zig").AutoDetectionConfiguration;
const AutoDetectionStatus = @import("auto_detection_status.zig").AutoDetectionStatus;

/// The auto-detection properties for a registry, including the requested
/// configuration and the current detection status. When auto-detection is
/// enabled and the scope preconditions are met, the registry is automatically
/// populated with discovered resources.
pub const AutoDetection = struct {
    /// The auto-detection settings that control how resources are discovered for
    /// the registry.
    configuration: AutoDetectionConfiguration,

    /// The current auto-detection status. `ACTIVE` indicates that the registry is
    /// actively being populated with detected resources. `INACTIVE` indicates that
    /// the preconditions required at the configured scope are not currently met.
    status: AutoDetectionStatus,

    /// A human-readable explanation of the current auto-detection status. Typically
    /// populated when the status requires additional context.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .status = "status",
        .status_reason = "statusReason",
    };
};
