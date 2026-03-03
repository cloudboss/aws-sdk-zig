const aws = @import("aws");

/// An activity that adds other attributes based on existing attributes in the
/// message.
pub const AddAttributesActivity = struct {
    /// A list of 1-50 `AttributeNameMapping` objects that map an existing attribute
    /// to
    /// a new attribute.
    ///
    /// The existing attributes remain in the message, so if you want to remove the
    /// originals,
    /// use `RemoveAttributeActivity`.
    attributes: []const aws.map.StringMapEntry,

    /// The name of the addAttributes activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .name = "name",
        .next = "next",
    };
};
