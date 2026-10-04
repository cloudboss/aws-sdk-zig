const Behavior = @import("behavior.zig").Behavior;

/// The rules configuration for conversational analytics. Controls whether
/// Contact Lens rules are evaluated against
/// the analytics output.
pub const RulesConfiguration = struct {
    /// Controls whether Contact Lens rules are evaluated for the contact. Valid
    /// values: `Enable` |
    /// `Disable`.
    behavior: ?Behavior = null,

    pub const json_field_names = .{
        .behavior = "Behavior",
    };
};
