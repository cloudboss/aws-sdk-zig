const ResourceOwnerAccount = @import("resource_owner_account.zig").ResourceOwnerAccount;
const ResourceOwnerOrg = @import("resource_owner_org.zig").ResourceOwnerOrg;

/// Information about the owner of a resource, including the account and
/// organization that the resource belongs to.
pub const ResourceOwner = struct {
    /// Information about the account that owns the resource, for example, an Azure
    /// Subscription or Amazon Web Services Account.
    account: ?ResourceOwnerAccount = null,

    /// Information about the organization that owns the resource, for example, an
    /// Azure Tenant.
    org: ?ResourceOwnerOrg = null,

    pub const json_field_names = .{
        .account = "Account",
        .org = "Org",
    };
};
