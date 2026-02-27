pub const OtaProtocol = enum {
    http,

    pub const json_field_names = .{
        .http = "HTTP",
    };
};
