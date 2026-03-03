/// Agentless Dialer config
pub const AgentlessDialerConfig = struct {
    dialing_capacity: ?f64 = null,

    pub const json_field_names = .{
        .dialing_capacity = "dialingCapacity",
    };
};
