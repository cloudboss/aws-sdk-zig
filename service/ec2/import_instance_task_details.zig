const PlatformValues = @import("platform_values.zig").PlatformValues;
const ImportInstanceVolumeDetailItem = @import("import_instance_volume_detail_item.zig").ImportInstanceVolumeDetailItem;

/// Describes an import instance task.
pub const ImportInstanceTaskDetails = struct {
    /// A description of the task.
    description: ?[]const u8 = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The instance operating system.
    platform: ?PlatformValues = null,

    /// The volumes.
    volumes: ?[]const ImportInstanceVolumeDetailItem = null,
};
