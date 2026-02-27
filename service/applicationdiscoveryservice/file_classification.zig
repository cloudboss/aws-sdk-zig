pub const FileClassification = enum {
    modelizeit_export,
    rvtools_export,
    vmware_nsx_export,
    import_template,

    pub const json_field_names = .{
        .modelizeit_export = "MODELIZEIT_EXPORT",
        .rvtools_export = "RVTOOLS_EXPORT",
        .vmware_nsx_export = "VMWARE_NSX_EXPORT",
        .import_template = "IMPORT_TEMPLATE",
    };
};
