pub const VolumeFilterName = enum {
    file_system_id,
    storage_virtual_machine_id,

    pub const json_field_names = .{
        .file_system_id = "FILE_SYSTEM_ID",
        .storage_virtual_machine_id = "STORAGE_VIRTUAL_MACHINE_ID",
    };
};
