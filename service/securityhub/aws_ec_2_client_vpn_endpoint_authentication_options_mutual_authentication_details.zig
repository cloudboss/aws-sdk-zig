/// Information about the client certificate used for authentication.
pub const AwsEc2ClientVpnEndpointAuthenticationOptionsMutualAuthenticationDetails = struct {
    /// The Amazon Resource Name (ARN) of the client certificate.
    client_root_certificate_chain: ?[]const u8,

    pub const json_field_names = .{
        .client_root_certificate_chain = "ClientRootCertificateChain",
    };
};
