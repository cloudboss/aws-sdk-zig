/// A structure within a `FilterCriteria` object that defines an event filtering
/// pattern.
pub const Filter = struct {
    /// A filter pattern. For more information on the syntax of a filter pattern,
    /// see [ Filter rule
    /// syntax](https://docs.aws.amazon.com/lambda/latest/dg/invocation-eventfiltering.html#filtering-syntax).
    pattern: ?[]const u8,
};
