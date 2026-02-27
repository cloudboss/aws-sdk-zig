pub const RemediationActionType = enum {
    remove,
    modify,

    pub const json_field_names = .{
        .remove = "Remove",
        .modify = "Modify",
    };
};
