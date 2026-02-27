/// Defines a Speech Synthesis Markup Language (SSML) prompt.
pub const SSMLMessage = struct {
    /// The SSML text that defines the prompt.
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
