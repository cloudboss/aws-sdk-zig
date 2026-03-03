pub const GetOperationRequest = struct {
    /// The ID of the operation that you want to get more information about.
    operation_id: []const u8,

    /// The ID of the Amazon Web Services account that owns the namespace associated
    /// with the operation, as specified in the namespace `ResourceOwner` field. For
    /// operations associated with namespaces that are shared with your account, you
    /// must specify an `OwnerAccount`.
    owner_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
        .owner_account = "OwnerAccount",
    };
};
