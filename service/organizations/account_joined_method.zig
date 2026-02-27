pub const AccountJoinedMethod = enum {
    invited,
    created,

    pub const json_field_names = .{
        .invited = "INVITED",
        .created = "CREATED",
    };
};
