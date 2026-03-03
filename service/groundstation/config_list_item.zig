const ConfigCapabilityType = @import("config_capability_type.zig").ConfigCapabilityType;

/// An item in a list of `Config` objects.
pub const ConfigListItem = struct {
    /// ARN of a `Config`.
    config_arn: ?[]const u8 = null,

    /// UUID of a `Config`.
    config_id: ?[]const u8 = null,

    /// Type of a `Config`.
    config_type: ?ConfigCapabilityType = null,

    /// Name of a `Config`.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .config_arn = "configArn",
        .config_id = "configId",
        .config_type = "configType",
        .name = "name",
    };
};
