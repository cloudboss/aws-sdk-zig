pub const CreationMode = enum {
    default,
    overridden,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .overridden = "OVERRIDDEN",
    };
};
