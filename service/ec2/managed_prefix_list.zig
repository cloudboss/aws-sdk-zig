const PrefixListState = @import("prefix_list_state.zig").PrefixListState;
const Tag = @import("tag.zig").Tag;

/// Describes a managed prefix list.
pub const ManagedPrefixList = struct {
    /// The IP address version.
    address_family: ?[]const u8 = null,

    /// Indicates whether synchronization with an IPAM prefix list resolver is
    /// enabled for this managed prefix list. When enabled, the prefix list CIDRs
    /// are automatically updated based on the resolver's CIDR selection rules.
    ipam_prefix_list_resolver_sync_enabled: ?bool = null,

    /// The ID of the IPAM prefix list resolver target associated with this managed
    /// prefix list. When set, this prefix list becomes an IPAM managed prefix list.
    ///
    /// An IPAM-managed prefix list is a customer-managed prefix list that has been
    /// associated with an IPAM prefix list resolver target. When a prefix list
    /// becomes IPAM managed, its CIDRs are automatically synchronized based on the
    /// IPAM prefix list resolver's CIDR selection rules, and direct CIDR
    /// modifications are restricted.
    ipam_prefix_list_resolver_target_id: ?[]const u8 = null,

    /// The maximum number of entries for the prefix list.
    max_entries: ?i32 = null,

    /// The ID of the owner of the prefix list.
    owner_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the prefix list.
    prefix_list_arn: ?[]const u8 = null,

    /// The ID of the prefix list.
    prefix_list_id: ?[]const u8 = null,

    /// The name of the prefix list.
    prefix_list_name: ?[]const u8 = null,

    /// The current state of the prefix list.
    state: ?PrefixListState = null,

    /// The state message.
    state_message: ?[]const u8 = null,

    /// The tags for the prefix list.
    tags: ?[]const Tag = null,

    /// The version of the prefix list.
    version: ?i64 = null,
};
