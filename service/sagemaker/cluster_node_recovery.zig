pub const ClusterNodeRecovery = enum {
    automatic,
    none,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .none = "NONE",
    };
};
