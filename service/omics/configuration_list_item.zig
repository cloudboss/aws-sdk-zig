const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

/// Configuration list item with summary information.
pub const ConfigurationListItem = struct {
    /// Unique resource identifier for the configuration.
    arn: ?[]const u8 = null,

    /// Configuration creation timestamp.
    creation_time: ?i64 = null,

    /// Description for the configuration.
    description: ?[]const u8 = null,

    /// User-friendly name for the configuration.
    name: ?[]const u8 = null,

    /// Current configuration status.
    status: ?ConfigurationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .name = "name",
        .status = "status",
    };
};
