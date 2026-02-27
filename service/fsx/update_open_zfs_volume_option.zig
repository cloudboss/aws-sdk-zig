pub const UpdateOpenZFSVolumeOption = enum {
    delete_intermediate_snapshots,
    delete_cloned_volumes,
    delete_intermediate_data,

    pub const json_field_names = .{
        .delete_intermediate_snapshots = "DELETE_INTERMEDIATE_SNAPSHOTS",
        .delete_cloned_volumes = "DELETE_CLONED_VOLUMES",
        .delete_intermediate_data = "DELETE_INTERMEDIATE_DATA",
    };
};
