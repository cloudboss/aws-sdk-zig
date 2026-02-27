/// A port range to specify the destination ports to inspect for.
pub const RuleGroupSourceStatelessRuleMatchAttributesDestinationPorts = struct {
    /// The starting port value for the port range.
    from_port: ?i32,

    /// The ending port value for the port range.
    to_port: ?i32,

    pub const json_field_names = .{
        .from_port = "FromPort",
        .to_port = "ToPort",
    };
};
