pub const RestoreOpenZFSVolumeOption = enum {
    delete_intermediate_snapshots,
    delete_cloned_volumes,

    pub const json_field_names = .{
        .delete_intermediate_snapshots = "DELETE_INTERMEDIATE_SNAPSHOTS",
        .delete_cloned_volumes = "DELETE_CLONED_VOLUMES",
    };
};
