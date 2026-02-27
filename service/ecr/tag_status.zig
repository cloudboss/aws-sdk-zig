pub const TagStatus = enum {
    tagged,
    untagged,
    any,

    pub const json_field_names = .{
        .tagged = "TAGGED",
        .untagged = "UNTAGGED",
        .any = "ANY",
    };
};
