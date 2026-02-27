pub const Status = enum {
    registered,
    incompatible_endpoint,

    pub const json_field_names = .{
        .registered = "REGISTERED",
        .incompatible_endpoint = "INCOMPATIBLE_ENDPOINT",
    };
};
