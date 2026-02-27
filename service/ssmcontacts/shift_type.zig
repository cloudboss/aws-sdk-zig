pub const ShiftType = enum {
    regular,
    overridden,

    pub const json_field_names = .{
        .regular = "REGULAR",
        .overridden = "OVERRIDDEN",
    };
};
