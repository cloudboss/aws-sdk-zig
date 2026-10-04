/// The configuration for session-sticky routing to a target. Session stickiness
/// routes requests that share a session identifier to the same target.
pub const StickinessConfiguration = struct {
    /// Additional headers to include in session affinity routing. When set,
    /// requests are only considered part of the same session if both the
    /// `identifier` and all composite identifier values match.
    composite_identifier: ?[]const []const u8 = null,

    /// The expression that identifies where to extract the session identifier from
    /// the request (for example, `$context.header.x-session-id`).
    identifier: []const u8,

    /// The session stickiness timeout, in seconds. After this duration of
    /// inactivity, the session affinity expires. Valid values range from 1 to
    /// 86400.
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .composite_identifier = "compositeIdentifier",
        .identifier = "identifier",
        .timeout = "timeout",
    };
};
