const VersionControlType = @import("version_control_type.zig").VersionControlType;

/// Details about the version control configuration.
pub const VersionControlInfo = struct {
    /// The time when the version control system was last configured.
    version_control_configuration_time_stamp: ?[]const u8,

    /// The type of version control.
    version_control_type: ?VersionControlType,

    pub const json_field_names = .{
        .version_control_configuration_time_stamp = "versionControlConfigurationTimeStamp",
        .version_control_type = "versionControlType",
    };
};
