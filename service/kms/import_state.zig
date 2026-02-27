pub const ImportState = enum {
    imported,
    pending_import,

    pub const json_field_names = .{
        .imported = "IMPORTED",
        .pending_import = "PENDING_IMPORT",
    };
};
