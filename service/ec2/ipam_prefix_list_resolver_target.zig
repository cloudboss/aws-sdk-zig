const IpamPrefixListResolverTargetState = @import("ipam_prefix_list_resolver_target_state.zig").IpamPrefixListResolverTargetState;
const Tag = @import("tag.zig").Tag;

/// Describes an IPAM prefix list resolver target.
///
/// An IPAM prefix list resolver target is an association between a specific
/// customer-managed prefix list and an IPAM prefix list resolver. The target
/// enables the resolver to synchronize CIDRs selected by its rules into the
/// specified prefix list, which can then be referenced in Amazon Web Services
/// resources.
pub const IpamPrefixListResolverTarget = struct {
    /// The desired version of the prefix list that this target should synchronize
    /// with.
    desired_version: ?i64 = null,

    /// The ID of the IPAM prefix list resolver associated with this target.
    ipam_prefix_list_resolver_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IPAM prefix list resolver target.
    ipam_prefix_list_resolver_target_arn: ?[]const u8 = null,

    /// The ID of the IPAM prefix list resolver target.
    ipam_prefix_list_resolver_target_id: ?[]const u8 = null,

    /// The version of the prefix list that was last successfully synchronized by
    /// this target.
    last_synced_version: ?i64 = null,

    /// The ID of the Amazon Web Services account that owns the IPAM prefix list
    /// resolver target.
    owner_id: ?[]const u8 = null,

    /// The ID of the managed prefix list associated with this target.
    prefix_list_id: ?[]const u8 = null,

    /// The Amazon Web Services Region where the prefix list associated with this
    /// target is located.
    prefix_list_region: ?[]const u8 = null,

    /// The current state of the IPAM prefix list resolver target. Valid values
    /// include `create-in-progress`, `create-complete`, `create-failed`,
    /// `modify-in-progress`, `modify-complete`, `modify-failed`,
    /// `delete-in-progress`, `delete-complete`, and `delete-failed`.
    state: ?IpamPrefixListResolverTargetState = null,

    /// A message describing the current state of the IPAM prefix list resolver
    /// target, including any error information.
    state_message: ?[]const u8 = null,

    /// The tags assigned to the IPAM prefix list resolver target.
    tags: ?[]const Tag = null,

    /// Indicates whether this target automatically tracks the latest version of the
    /// prefix list.
    track_latest_version: ?bool = null,
};
