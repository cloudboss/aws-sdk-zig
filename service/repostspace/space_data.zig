const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;
const SupportedEmailDomainsStatus = @import("supported_email_domains_status.zig").SupportedEmailDomainsStatus;
const TierLevel = @import("tier_level.zig").TierLevel;
const VanityDomainStatus = @import("vanity_domain_status.zig").VanityDomainStatus;

/// A structure that contains some information about a private re:Post in the
/// account.
pub const SpaceData = struct {
    /// The ARN of the private re:Post.
    arn: []const u8,

    /// The configuration status of the private re:Post.
    configuration_status: ConfigurationStatus,

    /// The content size of the private re:Post.
    content_size: ?i64,

    /// The date when the private re:Post was created.
    create_date_time: i64,

    /// The date when the private re:Post was deleted.
    delete_date_time: ?i64,

    /// The description for the private re:Post. This is used only to help you
    /// identify this private re:Post.
    description: ?[]const u8,

    /// The name for the private re:Post.
    name: []const u8,

    /// The AWS generated subdomain of the private re:Post.
    random_domain: []const u8,

    /// The unique ID of the private re:Post.
    space_id: []const u8,

    /// The creation/deletion status of the private re:Post.
    status: []const u8,

    /// The storage limit of the private re:Post.
    storage_limit: i64,

    supported_email_domains: ?SupportedEmailDomainsStatus,

    /// The pricing tier of the private re:Post.
    tier: TierLevel,

    /// The number of onboarded users to the private re:Post.
    user_count: ?i32,

    /// The custom AWS KMS key ARN that’s used for the AWS KMS encryption.
    user_kms_key: ?[]const u8,

    /// This custom subdomain that you use to access your private re:Post. All
    /// custom subdomains must be approved by AWS before use.
    vanity_domain: []const u8,

    /// This approval status of the custom subdomain.
    vanity_domain_status: VanityDomainStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .configuration_status = "configurationStatus",
        .content_size = "contentSize",
        .create_date_time = "createDateTime",
        .delete_date_time = "deleteDateTime",
        .description = "description",
        .name = "name",
        .random_domain = "randomDomain",
        .space_id = "spaceId",
        .status = "status",
        .storage_limit = "storageLimit",
        .supported_email_domains = "supportedEmailDomains",
        .tier = "tier",
        .user_count = "userCount",
        .user_kms_key = "userKMSKey",
        .vanity_domain = "vanityDomain",
        .vanity_domain_status = "vanityDomainStatus",
    };
};
