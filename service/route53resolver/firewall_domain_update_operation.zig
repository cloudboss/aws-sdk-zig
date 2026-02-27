pub const FirewallDomainUpdateOperation = enum {
    add,
    remove,
    replace,

    pub const json_field_names = .{
        .add = "ADD",
        .remove = "REMOVE",
        .replace = "REPLACE",
    };
};
