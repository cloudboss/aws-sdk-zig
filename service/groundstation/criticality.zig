pub const Criticality = enum {
    required,
    preferred,
    removed,

    pub const json_field_names = .{
        .required = "REQUIRED",
        .preferred = "PREFERRED",
        .removed = "REMOVED",
    };
};
