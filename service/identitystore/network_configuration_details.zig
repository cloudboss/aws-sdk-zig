/// The network configuration that controls how an identity store can be
/// accessed. This object is returned as part of service API responses.
pub const NetworkConfigurationDetails = struct {
    /// A list of IP address CIDR ranges that are allowed to access the identity
    /// store API operations. A request from an IP address in this list bypasses the
    /// identity store's other API network controls: it's permitted even if it
    /// doesn't come through a VPC endpoint required by `VpceAccessRequired`, and
    /// even if it doesn't originate from a VPC in `ApiRestrictSourceVpcs`. If this
    /// field is empty, no such IP address exception applies.
    api_allow_source_ips: ?[]const []const u8 = null,

    /// A list of virtual private cloud (VPC) IDs that are allowed to access the
    /// identity store API operations. A request is denied unless it originates from
    /// a VPC in this list, or from an IP address in `ApiAllowSourceIps` if one is
    /// configured. If this field is empty, access isn't restricted to specific
    /// VPCs, but the VPC endpoint requirement from `VpceAccessRequired` still
    /// applies.
    api_restrict_source_vpcs: ?[]const []const u8 = null,

    /// A list of IP address CIDR ranges that are allowed to access the identity
    /// store through the System for Cross-domain Identity Management (SCIM)
    /// protocol. Requests from IP addresses outside these ranges are denied. If
    /// this field is empty, SCIM requests remain subject to the identity store's
    /// other network controls, such as the VPC endpoint requirement.
    scim_allow_source_ips: ?[]const []const u8 = null,

    /// Specifies whether the identity store can be accessed only through a virtual
    /// private cloud (VPC) endpoint. When set to `true`, requests must originate
    /// from a VPC endpoint.
    vpce_access_required: bool,

    pub const json_field_names = .{
        .api_allow_source_ips = "ApiAllowSourceIps",
        .api_restrict_source_vpcs = "ApiRestrictSourceVpcs",
        .scim_allow_source_ips = "ScimAllowSourceIps",
        .vpce_access_required = "VpceAccessRequired",
    };
};
