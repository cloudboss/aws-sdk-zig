/// High-level information about a WebACL, returned by operations like create
/// and list. This provides information like the ID, that you can use to
/// retrieve and manage a `WebACL`, and the ARN, that you provide to operations
/// like AssociateWebACL.
pub const WebACLSummary = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: ?[]const u8,

    /// A description of the web ACL that helps with identification.
    description: ?[]const u8,

    /// The unique identifier for the web ACL. This ID is returned in the responses
    /// to create and list commands. You provide it to operations like update and
    /// delete.
    id: ?[]const u8,

    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    lock_token: ?[]const u8,

    /// The name of the web ACL. You cannot change the name of a web ACL after you
    /// create it.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .description = "Description",
        .id = "Id",
        .lock_token = "LockToken",
        .name = "Name",
    };
};
