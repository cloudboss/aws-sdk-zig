const SelectorType = @import("selector_type.zig").SelectorType;

/// A selector used to choose a specific configuration within a configurable
/// upfront rate card.
pub const Selector = struct {
    /// The category of the selector, such as `Duration`.
    type: SelectorType,

    /// The value of the selector.
    value: []const u8,

    pub const json_field_names = .{
        .type = "type",
        .value = "value",
    };
};
