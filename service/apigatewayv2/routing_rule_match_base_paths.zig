/// Represents a MatchBasePaths condition.
pub const RoutingRuleMatchBasePaths = struct {
    /// The string of the case sensitive base path to be matched.
    any_of: []const []const u8,

    pub const json_field_names = .{
        .any_of = "AnyOf",
    };
};
