pub const StackInstanceStatus = enum {
    current,
    outdated,
    inoperable,

    pub const json_field_names = .{
        .current = "CURRENT",
        .outdated = "OUTDATED",
        .inoperable = "INOPERABLE",
    };
};
