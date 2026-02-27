pub const SecurityPolicyType = enum {
    /// encryption policy type
    encryption,
    /// network policy type
    network,

    pub const json_field_names = .{
        .encryption = "encryption",
        .network = "network",
    };
};
