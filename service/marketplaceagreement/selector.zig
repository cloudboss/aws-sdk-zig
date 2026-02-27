/// Differentiates between the mutually exclusive rate cards in the same pricing
/// term to be selected by the buyer.
pub const Selector = struct {
    /// Category of selector.
    type: ?[]const u8,

    /// Contract duration. This field supports the ISO 8601 format.
    value: ?[]const u8,

    pub const json_field_names = .{
        .type = "type",
        .value = "value",
    };
};
