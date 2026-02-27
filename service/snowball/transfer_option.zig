pub const TransferOption = enum {
    import,
    @"export",
    local_use,

    pub const json_field_names = .{
        .import = "IMPORT",
        .@"export" = "EXPORT",
        .local_use = "LOCAL_USE",
    };
};
