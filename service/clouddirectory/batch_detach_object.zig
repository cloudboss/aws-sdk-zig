const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Represents the output of a DetachObject operation.
pub const BatchDetachObject = struct {
    /// The batch reference name. See [Transaction
    /// Support](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/transaction_support.html) for more information.
    batch_reference_name: ?[]const u8 = null,

    /// The name of the link.
    link_name: []const u8,

    /// Parent reference from which the object with the specified link name is
    /// detached.
    parent_reference: ObjectReference,

    pub const json_field_names = .{
        .batch_reference_name = "BatchReferenceName",
        .link_name = "LinkName",
        .parent_reference = "ParentReference",
    };
};
