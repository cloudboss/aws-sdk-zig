pub const ModelPackageType = enum {
    versioned,
    unversioned,
    both,

    pub const json_field_names = .{
        .versioned = "VERSIONED",
        .unversioned = "UNVERSIONED",
        .both = "BOTH",
    };
};
