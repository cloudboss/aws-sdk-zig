/// Describes the status of the Client VPN endpoint attribute.
pub const AwsEc2ClientVpnEndpointClientConnectOptionsStatusDetails = struct {
    /// The status code.
    code: ?[]const u8,

    /// The status message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
