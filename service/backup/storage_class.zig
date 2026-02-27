pub const StorageClass = enum {
    warm,
    cold,
    deleted,

    pub const json_field_names = .{
        .warm = "WARM",
        .cold = "COLD",
        .deleted = "DELETED",
    };
};
