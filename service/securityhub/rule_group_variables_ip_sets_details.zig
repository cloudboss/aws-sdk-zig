/// A list of IP addresses and address ranges, in CIDR notation.
pub const RuleGroupVariablesIpSetsDetails = struct {
    /// The list of IP addresses and ranges.
    definition: ?[]const []const u8,

    pub const json_field_names = .{
        .definition = "Definition",
    };
};
