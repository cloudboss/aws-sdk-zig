/// A structure that represents user-provided metadata that can be associated
/// with an IAM
/// resource. For more information about tagging, see [Tagging IAM
/// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
/// the
/// *IAM User Guide*.
pub const Tag = struct {
    /// The key name that can be used to look up or retrieve the associated value.
    /// For example,
    /// `Department` or `Cost Center` are common choices.
    key: []const u8,

    /// The value associated with this tag. For example, tags with a key name of
    /// `Department` could have values such as `Human Resources`,
    /// `Accounting`, and `Support`. Tags with a key name of `Cost
    /// Center` might have values that consist of the number associated with the
    /// different
    /// cost centers in your company. Typically, many resources have tags with the
    /// same key name but
    /// with different values.
    value: []const u8,
};
