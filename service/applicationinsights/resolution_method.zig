pub const ResolutionMethod = enum {
    manual,
    automatic,
    unresolved,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .automatic = "AUTOMATIC",
        .unresolved = "UNRESOLVED",
    };
};
