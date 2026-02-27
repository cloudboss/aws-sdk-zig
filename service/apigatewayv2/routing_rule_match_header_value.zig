/// Represents a MatchHeaderValue.
pub const RoutingRuleMatchHeaderValue = struct {
    header: []const u8,

    value_glob: []const u8,

    pub const json_field_names = .{
        .header = "Header",
        .value_glob = "ValueGlob",
    };
};
