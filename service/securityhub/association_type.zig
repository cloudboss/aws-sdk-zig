pub const AssociationType = enum {
    inherited,
    applied,

    pub const json_field_names = .{
        .inherited = "INHERITED",
        .applied = "APPLIED",
    };
};
