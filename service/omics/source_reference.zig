const SourceReferenceType = @import("source_reference_type.zig").SourceReferenceType;

/// Contains information about the source reference in a code repository, such
/// as a branch, tag, or commit.
pub const SourceReference = struct {
    /// The type of source reference, such as branch, tag, or commit.
    type: SourceReferenceType,

    /// The value of the source reference, such as the branch name, tag name, or
    /// commit ID.
    value: []const u8,

    pub const json_field_names = .{
        .type = "type",
        .value = "value",
    };
};
