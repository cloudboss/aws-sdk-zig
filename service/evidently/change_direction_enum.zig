pub const ChangeDirectionEnum = enum {
    increase,
    decrease,

    pub const json_field_names = .{
        .increase = "INCREASE",
        .decrease = "DECREASE",
    };
};
