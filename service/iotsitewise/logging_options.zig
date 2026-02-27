const LoggingLevel = @import("logging_level.zig").LoggingLevel;

/// Contains logging options.
pub const LoggingOptions = struct {
    /// The IoT SiteWise logging verbosity level.
    level: LoggingLevel,

    pub const json_field_names = .{
        .level = "level",
    };
};
