const IpamScopeExternalAuthorityConfiguration = @import("ipam_scope_external_authority_configuration.zig").IpamScopeExternalAuthorityConfiguration;
const IpamScopeType = @import("ipam_scope_type.zig").IpamScopeType;
const IpamScopeState = @import("ipam_scope_state.zig").IpamScopeState;
const Tag = @import("tag.zig").Tag;

/// In IPAM, a scope is the highest-level container within IPAM. An IPAM
/// contains two default scopes. Each scope represents the IP space for a single
/// network. The private scope is intended for all private IP address space. The
/// public scope is intended for all public IP address space. Scopes enable you
/// to reuse IP addresses across multiple unconnected networks without causing
/// IP address overlap or conflict.
///
/// For more information, see [How IPAM
/// works](https://docs.aws.amazon.com/vpc/latest/ipam/how-it-works-ipam.html)
/// in the *Amazon VPC IPAM User Guide*.
pub const IpamScope = struct {
    /// The description of the scope.
    description: ?[]const u8 = null,

    /// The external authority configuration for this IPAM scope, if configured.
    ///
    /// The configuration that links an Amazon VPC IPAM scope to an external
    /// authority system. It specifies the type of external system and the external
    /// resource identifier that identifies your account or instance in that system.
    ///
    /// In IPAM, an external authority is a third-party IP address management system
    /// that provides CIDR blocks when you provision address space for top-level
    /// IPAM pools. This allows you to use your existing IP management system to
    /// control which address ranges are allocated to Amazon Web Services while
    /// using Amazon VPC IPAM to manage subnets within those ranges.
    external_authority_configuration: ?IpamScopeExternalAuthorityConfiguration = null,

    /// The ARN of the IPAM.
    ipam_arn: ?[]const u8 = null,

    /// The Amazon Web Services Region of the IPAM scope.
    ipam_region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the scope.
    ipam_scope_arn: ?[]const u8 = null,

    /// The ID of the scope.
    ipam_scope_id: ?[]const u8 = null,

    /// The type of the scope.
    ipam_scope_type: ?IpamScopeType = null,

    /// Defines if the scope is the default scope or not.
    is_default: ?bool = null,

    /// The Amazon Web Services account ID of the owner of the scope.
    owner_id: ?[]const u8 = null,

    /// The number of pools in the scope.
    pool_count: ?i32 = null,

    /// The state of the IPAM scope.
    state: ?IpamScopeState = null,

    /// The key/value combination of a tag assigned to the resource. Use the tag key
    /// in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    tags: ?[]const Tag = null,
};
