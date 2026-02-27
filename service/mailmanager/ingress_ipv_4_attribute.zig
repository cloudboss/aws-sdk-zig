pub const IngressIpv4Attribute = enum {
    sender_ip,

    pub const json_field_names = .{
        .sender_ip = "SENDER_IP",
    };
};
