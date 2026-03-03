/// Describes the resource with which a prefix list is associated.
pub const PrefixListAssociation = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The owner of the resource.
    resource_owner: ?[]const u8 = null,
};
