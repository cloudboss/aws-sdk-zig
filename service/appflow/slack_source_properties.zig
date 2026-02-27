/// The properties that are applied when Slack is being used as a source.
pub const SlackSourceProperties = struct {
    /// The object specified in the Slack flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
