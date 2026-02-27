pub const ReplicationConfigurationDataPlaneRouting = enum {
    private_ip,
    public_ip,

    pub const json_field_names = .{
        .private_ip = "PRIVATE_IP",
        .public_ip = "PUBLIC_IP",
    };
};
