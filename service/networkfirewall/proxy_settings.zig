const ListenerProperty = @import("listener_property.zig").ListenerProperty;

/// The listener configuration for a proxy mode firewall. This specifies the
/// ports and protocols on which the firewall's proxy listens for traffic.
pub const ProxySettings = struct {
    /// Listener properties for HTTP and HTTPS traffic.
    listener_properties: []const ListenerProperty,

    pub const json_field_names = .{
        .listener_properties = "ListenerProperties",
    };
};
