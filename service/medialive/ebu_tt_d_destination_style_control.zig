/// Ebu Tt DDestination Style Control
pub const EbuTtDDestinationStyleControl = enum {
    exclude,
    include,

    pub const json_field_names = .{
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
    };
};
