pub const PhoneNumberOrderType = enum {
    new,
    porting,

    pub const json_field_names = .{
        .new = "New",
        .porting = "Porting",
    };
};
