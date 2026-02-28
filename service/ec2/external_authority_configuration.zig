const IpamScopeExternalAuthorityType = @import("ipam_scope_external_authority_type.zig").IpamScopeExternalAuthorityType;

/// The configuration that links an Amazon VPC IPAM scope to an external
/// authority system. It specifies the type of external system and the external
/// resource identifier that identifies your account or instance in that system.
///
/// For more information, see [Integrate VPC IPAM with Infoblox
/// infrastructure](https://docs.aws.amazon.com/vpc/latest/ipam/integrate-infoblox-ipam.html) in the *Amazon VPC IPAM User Guide*.
pub const ExternalAuthorityConfiguration = struct {
    /// The identifier for the external resource managing this scope. For Infoblox
    /// integrations, this is the Infoblox resource identifier in the format
    /// `.identity.account..`.
    external_resource_identifier: ?[]const u8,

    /// The type of external authority.
    @"type": ?IpamScopeExternalAuthorityType,
};
