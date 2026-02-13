pub const PatchOperationType = enum {
    scan,
    install,

    pub const json_field_names = .{
        .scan = "SCAN",
        .install = "INSTALL",
    };
};
