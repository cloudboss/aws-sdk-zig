pub const WirelessGatewayServiceType = enum {
    cups,
    lns,

    pub const json_field_names = .{
        .cups = "CUPS",
        .lns = "LNS",
    };
};
