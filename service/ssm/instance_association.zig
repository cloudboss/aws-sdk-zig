/// One or more association documents on the managed node.
pub const InstanceAssociation = struct {
    /// The association ID.
    association_id: ?[]const u8,

    /// Version information for the association on the managed node.
    association_version: ?[]const u8,

    /// The content of the association document for the managed nodes.
    content: ?[]const u8,

    /// The managed node ID.
    instance_id: ?[]const u8,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .association_version = "AssociationVersion",
        .content = "Content",
        .instance_id = "InstanceId",
    };
};
