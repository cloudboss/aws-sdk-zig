/// Information about the account that owns a resource, for example, an Azure
/// Subscription or Amazon Web Services Account.
pub const ResourceOwnerAccount = struct {
    /// The unique identifier of the account that owns the resource, for example,
    /// Azure Subscription Id or Amazon Web Services Account Id.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};
