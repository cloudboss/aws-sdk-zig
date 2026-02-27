/// Contains information about the observed behavior.
pub const Observations = struct {
    /// The text that was unusual.
    text: ?[]const []const u8,

    pub const json_field_names = .{
        .text = "Text",
    };
};
