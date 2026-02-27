/// The Tag type enables you to specify a key-value pair that can be used to
/// store information
/// about an CloudFormation stack.
pub const Tag = struct {
    /// A string used to identify this tag. You can specify a maximum of 128
    /// characters for a tag
    /// key. Tags owned by Amazon Web Services have the reserved prefix: `aws:`.
    key: []const u8,

    /// A string that contains the value for this tag. You can specify a maximum of
    /// 256 characters
    /// for a tag value.
    value: []const u8,
};
