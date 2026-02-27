/// The properties that are applied when using Zendesk as a flow source.
pub const ZendeskSourceProperties = struct {
    /// The object specified in the Zendesk flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
