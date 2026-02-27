/// Context information that enables CloudFormation to uniquely identify a
/// resource. CloudFormation uses
/// context key-value pairs in cases where a resource's logical and physical IDs
/// aren't enough to
/// uniquely identify that resource. Each context key-value pair specifies a
/// resource that contains
/// the targeted resource.
pub const PhysicalResourceIdContextKeyValuePair = struct {
    /// The resource context key.
    key: []const u8,

    /// The resource context value.
    value: []const u8,
};
