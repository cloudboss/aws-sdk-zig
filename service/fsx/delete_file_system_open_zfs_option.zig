pub const DeleteFileSystemOpenZFSOption = enum {
    delete_child_volumes_and_snapshots,

    pub const json_field_names = .{
        .delete_child_volumes_and_snapshots = "DELETE_CHILD_VOLUMES_AND_SNAPSHOTS",
    };
};
