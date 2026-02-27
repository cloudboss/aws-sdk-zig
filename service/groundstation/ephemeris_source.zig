pub const EphemerisSource = enum {
    customer_provided,
    space_track,

    pub const json_field_names = .{
        .customer_provided = "CUSTOMER_PROVIDED",
        .space_track = "SPACE_TRACK",
    };
};
