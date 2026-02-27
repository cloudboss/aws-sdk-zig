/// Represents a connection type.
pub const ConnectionType = enum {
    internet,
    vpc_link,

    pub const json_field_names = .{
        .internet = "INTERNET",
        .vpc_link = "VPC_LINK",
    };
};
