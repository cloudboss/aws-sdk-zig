const AddressFamily = @import("address_family.zig").AddressFamily;
const IpamPrefixListResolverVersionCreationStatus = @import("ipam_prefix_list_resolver_version_creation_status.zig").IpamPrefixListResolverVersionCreationStatus;
const IpamPrefixListResolverState = @import("ipam_prefix_list_resolver_state.zig").IpamPrefixListResolverState;
const Tag = @import("tag.zig").Tag;

/// Describes an IPAM prefix list resolver.
///
/// An IPAM prefix list resolver is a component that manages the synchronization
/// between IPAM's CIDR selection rules and customer-managed prefix lists. It
/// automates connectivity configurations by selecting CIDRs from IPAM's
/// database based on your business logic and synchronizing them with prefix
/// lists used in resources such as VPC route tables and security groups.
pub const IpamPrefixListResolver = struct {
    /// The address family (IPv4 or IPv6) for the IPAM prefix list resolver.
    address_family: ?AddressFamily = null,

    /// The description of the IPAM prefix list resolver.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IPAM associated with this resolver.
    ipam_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IPAM prefix list resolver.
    ipam_prefix_list_resolver_arn: ?[]const u8 = null,

    /// The ID of the IPAM prefix list resolver.
    ipam_prefix_list_resolver_id: ?[]const u8 = null,

    /// The Amazon Web Services Region where the associated IPAM is located.
    ipam_region: ?[]const u8 = null,

    /// The status for the last time a version was created.
    ///
    /// Each version is a snapshot of what CIDRs matched your rules at that moment
    /// in time. The version number increments every time the CIDR list
    /// changes due to infrastructure changes.
    last_version_creation_status: ?IpamPrefixListResolverVersionCreationStatus = null,

    /// The status message for the last time a version was created.
    ///
    /// Each version is a snapshot of what CIDRs matched your rules at that moment
    /// in time. The version number increments every time the CIDR list
    /// changes due to infrastructure changes.
    last_version_creation_status_message: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the IPAM prefix list
    /// resolver.
    owner_id: ?[]const u8 = null,

    /// The current state of the IPAM prefix list resolver. Valid values include
    /// `create-in-progress`, `create-complete`, `create-failed`,
    /// `modify-in-progress`, `modify-complete`, `modify-failed`,
    /// `delete-in-progress`, `delete-complete`, and `delete-failed`.
    state: ?IpamPrefixListResolverState = null,

    /// The tags assigned to the IPAM prefix list resolver.
    tags: ?[]const Tag = null,
};
