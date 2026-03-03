const GroupOwnerSetting = @import("group_owner_setting.zig").GroupOwnerSetting;

/// Attributes that define a local volume resource.
pub const LocalVolumeResourceData = struct {
    /// The absolute local path of the resource inside the Lambda environment.
    destination_path: ?[]const u8 = null,

    /// Allows you to configure additional group privileges for the Lambda process.
    /// This field is optional.
    group_owner_setting: ?GroupOwnerSetting = null,

    /// The local absolute path of the volume resource on the host. The source path
    /// for a volume resource type cannot start with ''/sys''.
    source_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_path = "DestinationPath",
        .group_owner_setting = "GroupOwnerSetting",
        .source_path = "SourcePath",
    };
};
