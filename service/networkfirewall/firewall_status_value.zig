pub const FirewallStatusValue = enum {
    provisioning,
    deleting,
    ready,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .deleting = "DELETING",
        .ready = "READY",
    };
};
