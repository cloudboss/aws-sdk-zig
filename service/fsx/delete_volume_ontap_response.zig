const Tag = @import("tag.zig").Tag;

/// The response object for the Amazon FSx for NetApp ONTAP volume being deleted
/// in the `DeleteVolume` operation.
pub const DeleteVolumeOntapResponse = struct {
    final_backup_id: ?[]const u8,

    final_backup_tags: ?[]const Tag,

    pub const json_field_names = .{
        .final_backup_id = "FinalBackupId",
        .final_backup_tags = "FinalBackupTags",
    };
};
