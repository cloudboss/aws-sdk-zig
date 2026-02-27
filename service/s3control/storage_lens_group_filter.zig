const StorageLensGroupAndOperator = @import("storage_lens_group_and_operator.zig").StorageLensGroupAndOperator;
const S3Tag = @import("s3_tag.zig").S3Tag;
const MatchObjectAge = @import("match_object_age.zig").MatchObjectAge;
const MatchObjectSize = @import("match_object_size.zig").MatchObjectSize;
const StorageLensGroupOrOperator = @import("storage_lens_group_or_operator.zig").StorageLensGroupOrOperator;

/// The filter element sets the criteria for the Storage Lens group data that is
/// displayed.
/// For multiple filter conditions, the `AND` or `OR` logical operator is
/// used.
pub const StorageLensGroupFilter = struct {
    /// A logical operator that allows multiple filter conditions to be joined for
    /// more complex
    /// comparisons of Storage Lens group data. Objects must match all of the listed
    /// filter
    /// conditions that are joined by the `And` logical operator. Only one of each
    /// filter condition is allowed.
    @"and": ?StorageLensGroupAndOperator,

    /// Contains a list of prefixes. At least one prefix must be specified. Up to 10
    /// prefixes
    /// are allowed.
    match_any_prefix: ?[]const []const u8,

    /// Contains a list of suffixes. At least one suffix must be specified. Up to 10
    /// suffixes
    /// are allowed.
    match_any_suffix: ?[]const []const u8,

    /// Contains the list of S3 object tags. At least one object tag must be
    /// specified. Up to
    /// 10 object tags are allowed.
    match_any_tag: ?[]const S3Tag,

    /// Contains `DaysGreaterThan` and `DaysLessThan` to define the
    /// object age range (minimum and maximum number of days).
    match_object_age: ?MatchObjectAge,

    /// Contains `BytesGreaterThan` and `BytesLessThan` to define the
    /// object size range (minimum and maximum number of Bytes).
    match_object_size: ?MatchObjectSize,

    /// A single logical operator that allows multiple filter conditions to be
    /// joined. Objects
    /// can match any of the listed filter conditions, which are joined by the `Or`
    /// logical operator. Only one of each filter condition is allowed.
    @"or": ?StorageLensGroupOrOperator,
};
