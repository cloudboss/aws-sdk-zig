const PolicyTypeSummary = @import("policy_type_summary.zig").PolicyTypeSummary;
const OrganizationFeatureSet = @import("organization_feature_set.zig").OrganizationFeatureSet;

/// Contains details about an organization. An organization is a collection of
/// accounts
/// that are centrally managed together using consolidated billing, organized
/// hierarchically
/// with organizational units (OUs), and controlled with policies .
pub const Organization = struct {
    /// The Amazon Resource Name (ARN) of an organization.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    arn: ?[]const u8,

    /// Do not use. This field is deprecated and doesn't provide complete
    /// information
    /// about the policies in your organization.
    ///
    /// To determine the policies that are enabled and available for use in your
    /// organization,
    /// use the ListRoots operation instead.
    available_policy_types: ?[]const PolicyTypeSummary,

    /// Specifies the functionality that currently is available to the organization.
    /// If set to
    /// "ALL", then all features are enabled and policies can be applied to accounts
    /// in the
    /// organization. If set to "CONSOLIDATED_BILLING", then only consolidated
    /// billing
    /// functionality is available. For more information, see [Enabling all features
    /// in your
    /// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html) in the *Organizations User Guide*.
    feature_set: ?OrganizationFeatureSet,

    /// The unique identifier (ID) of an organization.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for an organization ID
    /// string requires "o-"
    /// followed by from 10 to 32 lowercase letters or digits.
    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the account that is designated as the
    /// management
    /// account for the organization.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    master_account_arn: ?[]const u8,

    /// The email address that is associated with the Amazon Web Services account
    /// that is designated as the
    /// management account for the organization.
    master_account_email: ?[]const u8,

    /// The unique identifier (ID) of the management account of an organization.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for an account ID
    /// string requires exactly 12
    /// digits.
    master_account_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .available_policy_types = "AvailablePolicyTypes",
        .feature_set = "FeatureSet",
        .id = "Id",
        .master_account_arn = "MasterAccountArn",
        .master_account_email = "MasterAccountEmail",
        .master_account_id = "MasterAccountId",
    };
};
