/// The inspection criteria for a stateful rule.
pub const RuleGroupSourceStatefulRulesHeaderDetails = struct {
    /// The destination IP address or address range to inspect for, in CIDR
    /// notation. To match with any address, specify `ANY`.
    destination: ?[]const u8,

    /// The destination port to inspect for. You can specify an individual port,
    /// such as `1994`. You also can specify a port range, such as `1990:1994`. To
    /// match with any port, specify `ANY`.
    destination_port: ?[]const u8,

    /// The direction of traffic flow to inspect. If set to `ANY`, the inspection
    /// matches bidirectional traffic, both from the source to the destination and
    /// from the destination to the source. If set to `FORWARD`, the inspection only
    /// matches traffic going from the source to the destination.
    direction: ?[]const u8,

    /// The protocol to inspect for. To inspector for all protocols, use `IP`.
    protocol: ?[]const u8,

    /// The source IP address or address range to inspect for, in CIDR notation. To
    /// match with any address, specify `ANY`.
    source: ?[]const u8,

    /// The source port to inspect for. You can specify an individual port, such as
    /// `1994`. You also can specify a port range, such as `1990:1994`. To match
    /// with any port, specify `ANY`.
    source_port: ?[]const u8,

    pub const json_field_names = .{
        .destination = "Destination",
        .destination_port = "DestinationPort",
        .direction = "Direction",
        .protocol = "Protocol",
        .source = "Source",
        .source_port = "SourcePort",
    };
};
