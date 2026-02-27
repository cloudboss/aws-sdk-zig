pub const ReservedCapacityType = enum {
    ultraserver,
    instance,

    pub const json_field_names = .{
        .ultraserver = "ULTRASERVER",
        .instance = "INSTANCE",
    };
};
