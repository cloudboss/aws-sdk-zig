/// A pair of ObjectIdentifier and LinkName.
pub const ObjectIdentifierAndLinkNameTuple = struct {
    /// The name of the link between the parent and the child object.
    link_name: ?[]const u8 = null,

    /// The ID that is associated with the object.
    object_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .link_name = "LinkName",
        .object_identifier = "ObjectIdentifier",
    };
};
