pub const ReplicationType = enum {
    agent_based,
    snapshot_shipping,

    pub const json_field_names = .{
        .agent_based = "AGENT_BASED",
        .snapshot_shipping = "SNAPSHOT_SHIPPING",
    };
};
