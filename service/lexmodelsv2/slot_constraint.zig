pub const SlotConstraint = enum {
    required,
    optional,

    pub const json_field_names = .{
        .required = "Required",
        .optional = "Optional",
    };
};
