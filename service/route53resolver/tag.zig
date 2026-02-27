/// One tag that you want to add to the specified resource. A tag consists of a
/// `Key` (a name for the tag) and a `Value`.
pub const Tag = struct {
    /// The name for the tag. For example, if you want to associate Resolver
    /// resources with the account IDs of your customers for billing purposes,
    /// the value of `Key` might be `account-id`.
    key: []const u8,

    /// The value for the tag. For example, if `Key` is `account-id`, then `Value`
    /// might be the ID of the
    /// customer account that you're creating the resource for.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
