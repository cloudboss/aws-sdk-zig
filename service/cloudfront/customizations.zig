const Certificate = @import("certificate.zig").Certificate;
const GeoRestrictionCustomization = @import("geo_restriction_customization.zig").GeoRestrictionCustomization;
const WebAclCustomization = @import("web_acl_customization.zig").WebAclCustomization;

/// Customizations for the distribution tenant. For each distribution tenant,
/// you can specify the geographic restrictions, and the Amazon Resource Names
/// (ARNs) for the ACM certificate and WAF web ACL. These are specific values
/// that you can override or disable from the multi-tenant distribution that was
/// used to create the distribution tenant.
pub const Customizations = struct {
    /// The Certificate Manager (ACM) certificate.
    certificate: ?Certificate = null,

    /// The geographic restrictions.
    geo_restrictions: ?GeoRestrictionCustomization = null,

    /// The WAF web ACL.
    web_acl: ?WebAclCustomization = null,
};
