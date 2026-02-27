const ChangeTypeEnum = @import("change_type_enum.zig").ChangeTypeEnum;

/// Information about the file operation conflicts in a merge operation.
pub const MergeOperations = struct {
    /// The operation on a file in the destination of a merge or pull request.
    destination: ?ChangeTypeEnum,

    /// The operation (add, modify, or delete) on a file in the source of a merge or
    /// pull
    /// request.
    source: ?ChangeTypeEnum,

    pub const json_field_names = .{
        .destination = "destination",
        .source = "source",
    };
};
