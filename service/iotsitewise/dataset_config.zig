const SessionConfig = @import("session_config.zig").SessionConfig;

/// Contains the configuration for a dataset.
pub const DatasetConfig = struct {
    /// The session configuration for a session-type dataset.
    session: ?SessionConfig = null,

    pub const json_field_names = .{
        .session = "session",
    };
};
