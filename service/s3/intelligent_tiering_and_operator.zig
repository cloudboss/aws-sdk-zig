const Tag = @import("tag.zig").Tag;

/// A container for specifying S3 Intelligent-Tiering filters. The filters
/// determine the subset of
/// objects to which the rule applies.
pub const IntelligentTieringAndOperator = struct {
    /// An object key name prefix that identifies the subset of objects to which the
    /// configuration
    /// applies.
    prefix: ?[]const u8,

    /// All of these tags must exist in the object's tag set in order for the
    /// configuration to apply.
    tags: ?[]const Tag,
};
