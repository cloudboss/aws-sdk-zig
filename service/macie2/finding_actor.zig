const DomainDetails = @import("domain_details.zig").DomainDetails;
const IpAddressDetails = @import("ip_address_details.zig").IpAddressDetails;
const UserIdentity = @import("user_identity.zig").UserIdentity;

/// Provides information about an entity that performed an action that produced
/// a policy finding for a resource.
pub const FindingActor = struct {
    /// The domain name of the device that the entity used to perform the action on
    /// the affected resource.
    domain_details: ?DomainDetails,

    /// The IP address and related details about the device that the entity used to
    /// perform the action on the affected resource. The details can include
    /// information such as the owner and geographic location of the IP address.
    ip_address_details: ?IpAddressDetails,

    /// The type and other characteristics of the entity that performed the action
    /// on the affected resource. This value is null if the action was performed by
    /// an anonymous (unauthenticated) entity.
    user_identity: ?UserIdentity,

    pub const json_field_names = .{
        .domain_details = "domainDetails",
        .ip_address_details = "ipAddressDetails",
        .user_identity = "userIdentity",
    };
};
