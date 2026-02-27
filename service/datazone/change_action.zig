pub const ChangeAction = enum {
    publish,
    unpublish,

    pub const json_field_names = .{
        .publish = "PUBLISH",
        .unpublish = "UNPUBLISH",
    };
};
