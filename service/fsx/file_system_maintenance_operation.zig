/// An enumeration specifying the currently ongoing maintenance operation.
pub const FileSystemMaintenanceOperation = enum {
    patching,
    backing_up,

    pub const json_field_names = .{
        .patching = "PATCHING",
        .backing_up = "BACKING_UP",
    };
};
