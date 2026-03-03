const aws = @import("aws");

const License = @import("license.zig").License;
const EksAnywhereSubscriptionLicenseType = @import("eks_anywhere_subscription_license_type.zig").EksAnywhereSubscriptionLicenseType;
const EksAnywhereSubscriptionTerm = @import("eks_anywhere_subscription_term.zig").EksAnywhereSubscriptionTerm;

/// An EKS Anywhere subscription authorizing the customer to support for
/// licensed clusters
/// and access to EKS Anywhere Curated Packages.
pub const EksAnywhereSubscription = struct {
    /// The Amazon Resource Name (ARN) for the subscription.
    arn: ?[]const u8 = null,

    /// A boolean indicating whether or not a subscription will auto renew when it
    /// expires.
    auto_renew: bool = false,

    /// The Unix timestamp in seconds for when the subscription was created.
    created_at: ?i64 = null,

    /// The Unix timestamp in seconds for when the subscription is effective.
    effective_date: ?i64 = null,

    /// The Unix timestamp in seconds for when the subscription will expire or auto
    /// renew,
    /// depending on the auto renew configuration of the subscription object.
    expiration_date: ?i64 = null,

    /// UUID identifying a subscription.
    id: ?[]const u8 = null,

    /// Amazon Web Services License Manager ARN associated with the subscription.
    license_arns: ?[]const []const u8 = null,

    /// The number of licenses included in a subscription. Valid values are between
    /// 1 and
    /// 100.
    license_quantity: i32 = 0,

    /// Includes all of the claims in the license token necessary to validate the
    /// license for
    /// extended support.
    licenses: ?[]const License = null,

    /// The type of licenses included in the subscription. Valid value is CLUSTER.
    /// With the
    /// CLUSTER license type, each license covers support for a single EKS Anywhere
    /// cluster.
    license_type: ?EksAnywhereSubscriptionLicenseType = null,

    /// The status of a subscription.
    status: ?[]const u8 = null,

    /// The metadata for a subscription to assist with categorization and
    /// organization. Each
    /// tag consists of a key and an optional value. Subscription tags do not
    /// propagate to any
    /// other resources associated with the subscription.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// An EksAnywhereSubscriptionTerm object.
    term: ?EksAnywhereSubscriptionTerm = null,

    pub const json_field_names = .{
        .arn = "arn",
        .auto_renew = "autoRenew",
        .created_at = "createdAt",
        .effective_date = "effectiveDate",
        .expiration_date = "expirationDate",
        .id = "id",
        .license_arns = "licenseArns",
        .license_quantity = "licenseQuantity",
        .licenses = "licenses",
        .license_type = "licenseType",
        .status = "status",
        .tags = "tags",
        .term = "term",
    };
};
