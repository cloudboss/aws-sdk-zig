pub const LakehouseIdcRegistration = enum {
    associate,
    disassociate,

    pub const json_field_names = .{
        .associate = "ASSOCIATE",
        .disassociate = "DISASSOCIATE",
    };
};
