const ETagAlgorithm = @import("e_tag_algorithm.zig").ETagAlgorithm;

/// The entity tag (ETag) is a hash of the object representing its semantic
/// content.
pub const ETag = struct {
    /// The algorithm used to calculate the read set’s ETag(s).
    algorithm: ?ETagAlgorithm = null,

    /// The ETag hash calculated on Source1 of the read set.
    source_1: ?[]const u8 = null,

    /// The ETag hash calculated on Source2 of the read set.
    source_2: ?[]const u8 = null,

    pub const json_field_names = .{
        .algorithm = "algorithm",
        .source_1 = "source1",
        .source_2 = "source2",
    };
};
