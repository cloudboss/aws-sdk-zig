pub const RightsizingType = enum {
    terminate,
    modify,

    pub const json_field_names = .{
        .terminate = "TERMINATE",
        .modify = "MODIFY",
    };
};
