/// A set of TCP flags and masks to inspect for.
pub const RuleGroupSourceStatelessRuleMatchAttributesTcpFlags = struct {
    /// Defines the flags from the `Masks` setting that must be set in order for the
    /// packet to match. Flags that are listed must be set. Flags that are not
    /// listed must not be set.
    flags: ?[]const []const u8 = null,

    /// The set of flags to consider in the inspection. If not specified, then all
    /// flags are inspected.
    masks: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .flags = "Flags",
        .masks = "Masks",
    };
};
