const ApplicationType = @import("application_type.zig").ApplicationType;
const AuthorizedTokenIssuer = @import("authorized_token_issuer.zig").AuthorizedTokenIssuer;
const ServiceIntegrationsUnion = @import("service_integrations_union.zig").ServiceIntegrationsUnion;
const Tag = @import("tag.zig").Tag;

/// Contains properties for the Redshift IDC application.
pub const RedshiftIdcApplication = struct {
    /// The type of application being created. Valid values are `None` or
    /// `Lakehouse`. Use `Lakehouse` to enable Amazon Redshift federated permissions
    /// on cluster.
    application_type: ?ApplicationType = null,

    /// The authorized token issuer list for the Amazon Redshift IAM Identity Center
    /// application.
    authorized_token_issuer_list: ?[]const AuthorizedTokenIssuer = null,

    /// The ARN for the Amazon Redshift IAM Identity Center application. It has the
    /// required permissions to be assumed and invoke the IDC Identity Center API.
    iam_role_arn: ?[]const u8 = null,

    /// The display name for the Amazon Redshift IAM Identity Center application. It
    /// appears on the console.
    idc_display_name: ?[]const u8 = null,

    /// The ARN for the IAM Identity Center instance that Redshift integrates with.
    idc_instance_arn: ?[]const u8 = null,

    /// The ARN for the Amazon Redshift IAM Identity Center application.
    idc_managed_application_arn: ?[]const u8 = null,

    /// The onboarding status for the Amazon Redshift IAM Identity Center
    /// application.
    idc_onboard_status: ?[]const u8 = null,

    /// The identity namespace for the Amazon Redshift IAM Identity Center
    /// application. It determines which managed application verifies the connection
    /// token.
    identity_namespace: ?[]const u8 = null,

    /// The ARN for the Redshift application that integrates with IAM Identity
    /// Center.
    redshift_idc_application_arn: ?[]const u8 = null,

    /// The name of the Redshift application in IAM Identity Center.
    redshift_idc_application_name: ?[]const u8 = null,

    /// A list of service integrations for the Redshift IAM Identity Center
    /// application.
    service_integrations: ?[]const ServiceIntegrationsUnion = null,

    /// A list of tags keys that Redshift Identity Center applications copy to IAM
    /// Identity
    /// Center. For each input key, the tag corresponding to the key-value pair is
    /// propagated.
    sso_tag_keys: ?[]const []const u8 = null,

    /// A list of tags.
    tags: ?[]const Tag = null,
};
