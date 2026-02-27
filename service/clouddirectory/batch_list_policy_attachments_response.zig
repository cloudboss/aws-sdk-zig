/// Represents the output of a ListPolicyAttachments response operation.
pub const BatchListPolicyAttachmentsResponse = struct {
    /// The pagination token.
    next_token: ?[]const u8,

    /// A list of `ObjectIdentifiers` to which the policy is attached.
    object_identifiers: ?[]const []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .object_identifiers = "ObjectIdentifiers",
    };
};
