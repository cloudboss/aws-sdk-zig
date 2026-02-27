pub const ResolveConflicts = enum {
    overwrite,
    none,
    preserve,

    pub const json_field_names = .{
        .overwrite = "OVERWRITE",
        .none = "NONE",
        .preserve = "PRESERVE",
    };
};
