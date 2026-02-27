/// A list of IP addresses and address ranges, in CIDR notation. This is part of
/// a RuleVariables.
pub const IPSet = struct {
    /// The list of IP addresses and address ranges, in CIDR notation.
    definition: []const []const u8,

    pub const json_field_names = .{
        .definition = "Definition",
    };
};
