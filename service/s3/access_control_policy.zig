const Grant = @import("grant.zig").Grant;
const Owner = @import("owner.zig").Owner;

/// Contains the elements that set the ACL permissions for an object per
/// grantee.
pub const AccessControlPolicy = struct {
    /// A list of grants.
    grants: ?[]const Grant,

    /// Container for the bucket owner's display name and ID.
    owner: ?Owner,
};
