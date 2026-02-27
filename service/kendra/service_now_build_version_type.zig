pub const ServiceNowBuildVersionType = enum {
    london,
    others,

    pub const json_field_names = .{
        .london = "LONDON",
        .others = "OTHERS",
    };
};
