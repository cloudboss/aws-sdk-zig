const TunnelProtocol = @import("tunnel_protocol.zig").TunnelProtocol;

/// Describes a core network Connect attachment options.
pub const ConnectAttachmentOptions = struct {
    /// The protocol used for the attachment connection.
    protocol: ?TunnelProtocol,

    pub const json_field_names = .{
        .protocol = "Protocol",
    };
};
