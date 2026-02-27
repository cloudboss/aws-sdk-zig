/// Provides details about an Active Directory that’s used to authenticate an
/// Client VPN endpoint.
pub const AwsEc2ClientVpnEndpointAuthenticationOptionsActiveDirectoryDetails = struct {
    /// The ID of the Active Directory used for authentication.
    directory_id: ?[]const u8,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};
