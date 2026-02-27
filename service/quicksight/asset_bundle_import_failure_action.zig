pub const AssetBundleImportFailureAction = enum {
    do_nothing,
    rollback,

    pub const json_field_names = .{
        .do_nothing = "DO_NOTHING",
        .rollback = "ROLLBACK",
    };
};
