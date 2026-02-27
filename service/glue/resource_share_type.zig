pub const ResourceShareType = enum {
    foreign,
    all,
    federated,

    pub const json_field_names = .{
        .foreign = "FOREIGN",
        .all = "ALL",
        .federated = "FEDERATED",
    };
};
