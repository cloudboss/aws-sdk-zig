/// Used in NodeInterfaceMapping and NodeInterfaceMappingCreateRequest
pub const NetworkInterfaceMode = enum {
    nat,
    bridge,

    pub const json_field_names = .{
        .nat = "NAT",
        .bridge = "BRIDGE",
    };
};
