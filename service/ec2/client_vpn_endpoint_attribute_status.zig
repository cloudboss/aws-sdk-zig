const ClientVpnEndpointAttributeStatusCode = @import("client_vpn_endpoint_attribute_status_code.zig").ClientVpnEndpointAttributeStatusCode;

/// Describes the status of the Client VPN endpoint attribute.
pub const ClientVpnEndpointAttributeStatus = struct {
    /// The status code.
    code: ?ClientVpnEndpointAttributeStatusCode = null,

    /// The status message.
    message: ?[]const u8 = null,
};
