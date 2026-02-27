pub const ControlState = enum {
    active,
    end_of_support,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .end_of_support = "END_OF_SUPPORT",
    };
};
