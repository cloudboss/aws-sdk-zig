pub const FirewallDeploymentModel = enum {
    centralized,
    distributed,

    pub const json_field_names = .{
        .centralized = "CENTRALIZED",
        .distributed = "DISTRIBUTED",
    };
};
