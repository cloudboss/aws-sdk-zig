pub const Fault = enum {
    client,
    server,
    unknown,

    pub const json_field_names = .{
        .client = "Client",
        .server = "Server",
        .unknown = "Unknown",
    };
};
