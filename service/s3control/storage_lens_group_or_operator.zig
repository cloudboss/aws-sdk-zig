const S3Tag = @import("s3_tag.zig").S3Tag;
const MatchObjectAge = @import("match_object_age.zig").MatchObjectAge;
const MatchObjectSize = @import("match_object_size.zig").MatchObjectSize;

/// A container element for specifying `Or` rule conditions. The rule conditions
/// determine the subset of objects to which the `Or` rule applies. Objects can
/// match any of the listed filter conditions, which are joined by the `Or`
/// logical
/// operator. Only one of each filter condition is allowed.
pub const StorageLensGroupOrOperator = struct {
    /// Filters objects that match any of the specified prefixes.
    match_any_prefix: ?[]const []const u8,

    /// Filters objects that match any of the specified suffixes.
    match_any_suffix: ?[]const []const u8,

    /// Filters objects that match any of the specified S3 object tags.
    match_any_tag: ?[]const S3Tag,

    /// Filters objects that match the specified object age range.
    match_object_age: ?MatchObjectAge,

    /// Filters objects that match the specified object size range.
    match_object_size: ?MatchObjectSize,
};
