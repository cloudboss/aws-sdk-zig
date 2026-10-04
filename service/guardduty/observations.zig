/// Contains information about the observed behavior.
pub const Observations = struct {
    /// The numeric values that were unusual.
    number: ?[]const i64 = null,

    /// The text that was unusual.
    text: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .number = "Number",
        .text = "Text",
    };
};
