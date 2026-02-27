pub const FilterableMemberStatus = enum {
    invited,
    active,

    pub const json_field_names = .{
        .invited = "INVITED",
        .active = "ACTIVE",
    };
};
