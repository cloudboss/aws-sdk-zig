/// Specifies whether the input device has been configured (outside of
/// MediaLive) to use a dynamic IP address assignment (DHCP) or a static IP
/// address.
pub const InputDeviceIpScheme = enum {
    static,
    dhcp,

    pub const json_field_names = .{
        .static = "STATIC",
        .dhcp = "DHCP",
    };
};
