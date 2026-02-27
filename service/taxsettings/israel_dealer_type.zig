pub const IsraelDealerType = enum {
    authorized,
    non_authorized,

    pub const json_field_names = .{
        .authorized = "AUTHORIZED",
        .non_authorized = "NON_AUTHORIZED",
    };
};
