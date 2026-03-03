const PreferredProtocol = @import("preferred_protocol.zig").PreferredProtocol;

/// The streaming protocol you want your stack to prefer. This can be UDP or
/// TCP. Currently, UDP is only supported in the Windows native client.
pub const StreamingExperienceSettings = struct {
    /// The preferred protocol that you want to use while streaming your
    /// application.
    preferred_protocol: ?PreferredProtocol = null,

    pub const json_field_names = .{
        .preferred_protocol = "PreferredProtocol",
    };
};
