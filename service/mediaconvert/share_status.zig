pub const ShareStatus = enum {
    not_shared,
    initiated,
    shared,

    pub const json_field_names = .{
        .not_shared = "NOT_SHARED",
        .initiated = "INITIATED",
        .shared = "SHARED",
    };
};
