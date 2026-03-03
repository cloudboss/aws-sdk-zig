/// The details related to a specific AttributeGroup.
pub const AttributeGroupDetails = struct {
    /// The Amazon resource name (ARN) that specifies the attribute group.
    arn: ?[]const u8 = null,

    /// The service principal that created the attribute group.
    created_by: ?[]const u8 = null,

    /// The unique identifier of the attribute group.
    id: ?[]const u8 = null,

    /// This field is no longer supported.
    /// We recommend
    /// you don't use the field when using `ListAttributeGroupsForApplication`.
    ///
    /// The name of the attribute group.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_by = "createdBy",
        .id = "id",
        .name = "name",
    };
};
