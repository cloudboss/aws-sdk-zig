pub const ImageTagMutability = enum {
    mutable,
    immutable,
    immutable_with_exclusion,
    mutable_with_exclusion,

    pub const json_field_names = .{
        .mutable = "MUTABLE",
        .immutable = "IMMUTABLE",
        .immutable_with_exclusion = "IMMUTABLE_WITH_EXCLUSION",
        .mutable_with_exclusion = "MUTABLE_WITH_EXCLUSION",
    };
};
