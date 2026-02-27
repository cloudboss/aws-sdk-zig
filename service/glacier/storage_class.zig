pub const StorageClass = enum {
    standard,
    reduced_redundancy,
    standard_infrequent_access,

    pub const json_field_names = .{
        .standard = "Standard",
        .reduced_redundancy = "ReducedRedundancy",
        .standard_infrequent_access = "StandardInfrequentAccess",
    };
};
