const CustomDomainConfigType = @import("custom_domain_config_type.zig").CustomDomainConfigType;
const DomainStatusType = @import("domain_status_type.zig").DomainStatusType;

/// A container for information about the user pool domain associated with the
/// hosted UI
/// and OAuth endpoints.
pub const DomainDescriptionType = struct {
    /// The Amazon Web Services account that you created the user pool in.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon CloudFront endpoint that hosts your custom domain.
    cloud_front_distribution: ?[]const u8 = null,

    /// The configuration for a custom domain that hosts the sign-up and sign-in
    /// webpages for
    /// your application.
    custom_domain_config: ?CustomDomainConfigType = null,

    /// The domain string. For custom domains, this is the fully-qualified domain
    /// name, such
    /// as `auth.example.com`. For Amazon Cognito prefix domains, this is the prefix
    /// alone,
    /// such as `auth`.
    domain: ?[]const u8 = null,

    /// The version of managed login branding that you want to apply to your domain.
    /// A value
    /// of `1` indicates hosted UI (classic) branding and a version of `2`
    /// indicates managed login branding.
    ///
    /// Managed login requires that your user pool be configured for any [feature
    /// plan](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-sign-in-feature-plans.html) other than `Lite`.
    managed_login_version: ?i32 = null,

    /// The Amazon S3 bucket where the static files for this domain are stored.
    s3_bucket: ?[]const u8 = null,

    /// The domain status.
    status: ?DomainStatusType = null,

    /// The ID of the user pool that the domain is attached to.
    user_pool_id: ?[]const u8 = null,

    /// The app version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AWSAccountId",
        .cloud_front_distribution = "CloudFrontDistribution",
        .custom_domain_config = "CustomDomainConfig",
        .domain = "Domain",
        .managed_login_version = "ManagedLoginVersion",
        .s3_bucket = "S3Bucket",
        .status = "Status",
        .user_pool_id = "UserPoolId",
        .version = "Version",
    };
};
