pub const ClientVersion = enum {
    five_one,
    five_three,

    pub const json_field_names = .{
        .five_one = "FIVE_ONE",
        .five_three = "FIVE_THREE",
    };
};
