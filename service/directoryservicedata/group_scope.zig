pub const GroupScope = enum {
    domain_local,
    global,
    universal,
    builtin_local,

    pub const json_field_names = .{
        .domain_local = "DOMAIN_LOCAL",
        .global = "GLOBAL",
        .universal = "UNIVERSAL",
        .builtin_local = "BUILTIN_LOCAL",
    };
};
