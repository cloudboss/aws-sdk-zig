const S3Tag = @import("s3_tag.zig").S3Tag;
const MatchObjectAge = @import("match_object_age.zig").MatchObjectAge;
const MatchObjectSize = @import("match_object_size.zig").MatchObjectSize;

/// A logical operator that allows multiple filter conditions to be joined for
/// more complex
/// comparisons of Storage Lens group data.
pub const StorageLensGroupAndOperator = struct {
    /// Contains a list of prefixes. At least one prefix must be specified. Up to 10
    /// prefixes
    /// are allowed.
    match_any_prefix: ?[]const []const u8 = null,

    /// Contains a list of suffixes. At least one suffix must be specified. Up to 10
    /// suffixes
    /// are allowed.
    match_any_suffix: ?[]const []const u8 = null,

    /// Contains the list of object tags. At least one object tag must be specified.
    /// Up to 10
    /// object tags are allowed.
    match_any_tag: ?[]const S3Tag = null,

    /// Contains `DaysGreaterThan` and `DaysLessThan` to define the
    /// object age range (minimum and maximum number of days).
    match_object_age: ?MatchObjectAge = null,

    /// Contains `BytesGreaterThan` and `BytesLessThan` to define the
    /// object size range (minimum and maximum number of Bytes).
    match_object_size: ?MatchObjectSize = null,
};
