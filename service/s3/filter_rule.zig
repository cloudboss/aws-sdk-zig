const FilterRuleName = @import("filter_rule_name.zig").FilterRuleName;

/// Specifies the Amazon S3 object key name to filter on. An object key name is
/// the name assigned to an
/// object in your Amazon S3 bucket. You specify whether to filter on the suffix
/// or prefix of the object key
/// name. A prefix is a specific string of characters at the beginning of an
/// object key name, which you can
/// use to organize objects. For example, you can start the key names of related
/// objects with a prefix, such
/// as `2023-` or `engineering/`. Then, you can use `FilterRule` to find
/// objects in a bucket with key names that have the same prefix. A suffix is
/// similar to a prefix, but it is
/// at the end of the object key name instead of at the beginning.
pub const FilterRule = struct {
    /// The object key name prefix or suffix identifying one or more objects to
    /// which the filtering rule
    /// applies. The maximum length is 1,024 characters. Overlapping prefixes and
    /// suffixes are not supported.
    /// For more information, see [Configuring Event
    /// Notifications](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in the *Amazon S3 User Guide*.
    name: ?FilterRuleName,

    /// The value that the filter searches for in object key names.
    value: ?[]const u8,
};
