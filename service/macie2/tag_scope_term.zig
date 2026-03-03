const JobComparator = @import("job_comparator.zig").JobComparator;
const TagValuePair = @import("tag_value_pair.zig").TagValuePair;
const TagTarget = @import("tag_target.zig").TagTarget;

/// Specifies a tag-based condition that determines whether an S3 object is
/// included or excluded from a classification job.
pub const TagScopeTerm = struct {
    /// The operator to use in the condition. Valid values are EQ (equals) or NE
    /// (not equals).
    comparator: ?JobComparator = null,

    /// The object property to use in the condition. The only valid value is TAG.
    key: ?[]const u8 = null,

    /// The tag keys or tag key and value pairs to use in the condition. To specify
    /// only tag keys in a condition, specify the keys in this array and set the
    /// value for each associated tag value to an empty string.
    tag_values: ?[]const TagValuePair = null,

    /// The type of object to apply the condition to.
    target: ?TagTarget = null,

    pub const json_field_names = .{
        .comparator = "comparator",
        .key = "key",
        .tag_values = "tagValues",
        .target = "target",
    };
};
