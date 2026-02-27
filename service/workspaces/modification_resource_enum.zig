pub const ModificationResourceEnum = enum {
    root_volume,
    user_volume,
    compute_type,

    pub const json_field_names = .{
        .root_volume = "ROOT_VOLUME",
        .user_volume = "USER_VOLUME",
        .compute_type = "COMPUTE_TYPE",
    };
};
