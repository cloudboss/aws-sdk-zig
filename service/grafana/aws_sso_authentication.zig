/// A structure containing information about how this workspace works with IAM
/// Identity Center.
pub const AwsSsoAuthentication = struct {
    /// The ID of the IAM Identity Center-managed application that is created by
    /// Amazon Managed Grafana.
    sso_client_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .sso_client_id = "ssoClientId",
    };
};
