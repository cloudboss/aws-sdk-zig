const CognitoConfig = @import("cognito_config.zig").CognitoConfig;
const WorkforceIpAddressType = @import("workforce_ip_address_type.zig").WorkforceIpAddressType;
const OidcConfigForResponse = @import("oidc_config_for_response.zig").OidcConfigForResponse;
const SourceIpConfig = @import("source_ip_config.zig").SourceIpConfig;
const WorkforceStatus = @import("workforce_status.zig").WorkforceStatus;
const WorkforceVpcConfigResponse = @import("workforce_vpc_config_response.zig").WorkforceVpcConfigResponse;

/// A single private workforce, which is automatically created when you create
/// your first private work team. You can create one private work force in each
/// Amazon Web Services Region. By default, any workforce-related API operation
/// used in a specific region will apply to the workforce created in that
/// region. To learn how to create a private workforce, see [Create a Private
/// Workforce](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-workforce-create-private.html).
pub const Workforce = struct {
    /// The configuration of an Amazon Cognito workforce. A single Cognito workforce
    /// is created using and corresponds to a single [ Amazon Cognito user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html).
    cognito_config: ?CognitoConfig = null,

    /// The date that the workforce is created.
    create_date: ?i64 = null,

    /// The reason your workforce failed.
    failure_reason: ?[]const u8 = null,

    /// The IP address type you specify - either `IPv4` only or `dualstack` (`IPv4`
    /// and `IPv6`) - to support your labeling workforce.
    ip_address_type: ?WorkforceIpAddressType = null,

    /// The most recent date that
    /// [UpdateWorkforce](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateWorkforce.html) was used to successfully add one or more IP address ranges ([CIDRs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)) to a private workforce's allow list.
    last_updated_date: ?i64 = null,

    /// The configuration of an OIDC Identity Provider (IdP) private workforce.
    oidc_config: ?OidcConfigForResponse = null,

    /// A list of one to ten IP address ranges
    /// ([CIDRs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html))
    /// to be added to the workforce allow list. By default, a workforce isn't
    /// restricted to specific IP addresses.
    source_ip_config: ?SourceIpConfig = null,

    /// The status of your workforce.
    status: ?WorkforceStatus = null,

    /// The subdomain for your OIDC Identity Provider.
    sub_domain: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the private workforce.
    workforce_arn: []const u8,

    /// The name of the private workforce.
    workforce_name: []const u8,

    /// The configuration of a VPC workforce.
    workforce_vpc_config: ?WorkforceVpcConfigResponse = null,

    pub const json_field_names = .{
        .cognito_config = "CognitoConfig",
        .create_date = "CreateDate",
        .failure_reason = "FailureReason",
        .ip_address_type = "IpAddressType",
        .last_updated_date = "LastUpdatedDate",
        .oidc_config = "OidcConfig",
        .source_ip_config = "SourceIpConfig",
        .status = "Status",
        .sub_domain = "SubDomain",
        .workforce_arn = "WorkforceArn",
        .workforce_name = "WorkforceName",
        .workforce_vpc_config = "WorkforceVpcConfig",
    };
};
