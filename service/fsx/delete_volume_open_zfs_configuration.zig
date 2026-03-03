const DeleteOpenZFSVolumeOption = @import("delete_open_zfs_volume_option.zig").DeleteOpenZFSVolumeOption;

/// A value that specifies whether to delete all child volumes and snapshots.
pub const DeleteVolumeOpenZFSConfiguration = struct {
    /// To delete the volume's child volumes, snapshots, and clones, use the string
    /// `DELETE_CHILD_VOLUMES_AND_SNAPSHOTS`.
    options: ?[]const DeleteOpenZFSVolumeOption = null,

    pub const json_field_names = .{
        .options = "Options",
    };
};
