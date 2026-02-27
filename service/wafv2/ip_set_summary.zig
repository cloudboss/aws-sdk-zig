/// High-level information about an IPSet, returned by operations like create
/// and list. This provides information like the ID, that you can use to
/// retrieve and manage an `IPSet`, and the ARN, that you provide to the
/// IPSetReferenceStatement to use the address set in a Rule.
pub const IPSetSummary = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: ?[]const u8,

    /// A description of the IP set that helps with identification.
    description: ?[]const u8,

    /// A unique identifier for the set. This ID is returned in the responses to
    /// create and list commands. You provide it to operations like update and
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

    /// The name of the IP set. You cannot change the name of an `IPSet` after you
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
