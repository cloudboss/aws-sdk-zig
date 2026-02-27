pub const KeyExportability = enum {
    exportable,
    non_exportable,
    sensitive,

    pub const json_field_names = .{
        .exportable = "EXPORTABLE",
        .non_exportable = "NON_EXPORTABLE",
        .sensitive = "SENSITIVE",
    };
};
