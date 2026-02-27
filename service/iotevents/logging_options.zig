const DetectorDebugOption = @import("detector_debug_option.zig").DetectorDebugOption;
const LoggingLevel = @import("logging_level.zig").LoggingLevel;

/// The values of the AWS IoT Events logging options.
pub const LoggingOptions = struct {
    /// Information that identifies those detector models and their detectors
    /// (instances) for
    /// which the logging level is given.
    detector_debug_options: ?[]const DetectorDebugOption,

    /// If TRUE, logging is enabled for AWS IoT Events.
    enabled: bool = false,

    /// The logging level.
    level: LoggingLevel,

    /// The ARN of the role that grants permission to AWS IoT Events to perform
    /// logging.
    role_arn: []const u8,

    pub const json_field_names = .{
        .detector_debug_options = "detectorDebugOptions",
        .enabled = "enabled",
        .level = "level",
        .role_arn = "roleArn",
    };
};
