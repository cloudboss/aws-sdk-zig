pub const LicenseCountingType = enum {
    vcpu,
    instance,
    core,
    socket,

    pub const json_field_names = .{
        .vcpu = "VCPU",
        .instance = "INSTANCE",
        .core = "CORE",
        .socket = "SOCKET",
    };
};
