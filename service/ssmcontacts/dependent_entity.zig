/// Information about a resource that another resource is related to or depends
/// on.
///
/// For example, if a contact is a member of a rotation, the rotation is a
/// dependent entity
/// of the contact.
pub const DependentEntity = struct {
    /// The Amazon Resource Names (ARNs) of the dependent resources.
    dependent_resource_ids: []const []const u8,

    /// The type of relationship between one resource and the other resource that it
    /// is related
    /// to or depends on.
    relation_type: []const u8,

    pub const json_field_names = .{
        .dependent_resource_ids = "DependentResourceIds",
        .relation_type = "RelationType",
    };
};
