pub const OpenZFSQuotaType = enum {
    user,
    group,

    pub const json_field_names = .{
        .user = "USER",
        .group = "GROUP",
    };
};
