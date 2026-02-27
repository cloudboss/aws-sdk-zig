/// Represents passthrough behavior for an integration response. Supported only
/// for WebSocket APIs.
pub const PassthroughBehavior = enum {
    when_no_match,
    never,
    when_no_templates,

    pub const json_field_names = .{
        .when_no_match = "WHEN_NO_MATCH",
        .never = "NEVER",
        .when_no_templates = "WHEN_NO_TEMPLATES",
    };
};
