const IpamScopeExternalAuthorityType = @import("ipam_scope_external_authority_type.zig").IpamScopeExternalAuthorityType;

/// The configuration that links an Amazon VPC IPAM scope to an external
/// authority system. It specifies the type of external system and the external
/// resource identifier that identifies your account or instance in that system.
///
/// In IPAM, an external authority is a third-party IP address management system
/// that provides CIDR blocks when you provision address space for top-level
/// IPAM pools. This allows you to use your existing IP management system to
/// control which address ranges are allocated to Amazon Web Services while
/// using Amazon VPC IPAM to manage subnets within those ranges.
pub const IpamScopeExternalAuthorityConfiguration = struct {
    /// The identifier for the external resource managing this scope. For Infoblox
    /// integrations, this is the Infoblox resource identifier in the format
    /// `.identity.account..`.
    external_resource_identifier: ?[]const u8,

    /// The type of external authority managing this scope. Currently supports
    /// `Infoblox` for integration with Infoblox Universal DDI.
    @"type": ?IpamScopeExternalAuthorityType,
};
