const NetworkAclAssociation = @import("network_acl_association.zig").NetworkAclAssociation;
const NetworkAclEntry = @import("network_acl_entry.zig").NetworkAclEntry;
const Tag = @import("tag.zig").Tag;

/// Describes a network ACL.
pub const NetworkAcl = struct {
    /// Any associations between the network ACL and your subnets
    associations: ?[]const NetworkAclAssociation,

    /// The entries (rules) in the network ACL.
    entries: ?[]const NetworkAclEntry,

    /// Indicates whether this is the default network ACL for the VPC.
    is_default: ?bool,

    /// The ID of the network ACL.
    network_acl_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the network ACL.
    owner_id: ?[]const u8,

    /// Any tags assigned to the network ACL.
    tags: ?[]const Tag,

    /// The ID of the VPC for the network ACL.
    vpc_id: ?[]const u8,
};
