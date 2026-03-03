const GroupOwnerSetting = @import("group_owner_setting.zig").GroupOwnerSetting;

/// Attributes that define a local device resource.
pub const LocalDeviceResourceData = struct {
    /// Group/owner related settings for local resources.
    group_owner_setting: ?GroupOwnerSetting = null,

    /// The local absolute path of the device resource. The source path for a device
    /// resource can refer only to a character device or block device under
    /// ''/dev''.
    source_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_owner_setting = "GroupOwnerSetting",
        .source_path = "SourcePath",
    };
};
