const ObjectTypeEnum = @import("object_type_enum.zig").ObjectTypeEnum;

/// Information about the type of an object in a merge operation.
pub const ObjectTypes = struct {
    /// The type of the object in the base commit of the merge.
    base: ?ObjectTypeEnum,

    /// The type of the object in the destination branch.
    destination: ?ObjectTypeEnum,

    /// The type of the object in the source branch.
    source: ?ObjectTypeEnum,

    pub const json_field_names = .{
        .base = "base",
        .destination = "destination",
        .source = "source",
    };
};
