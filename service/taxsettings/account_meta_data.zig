const aws = @import("aws");

const Address = @import("address.zig").Address;
const Jurisdiction = @import("jurisdiction.zig").Jurisdiction;
const AddressRoleType = @import("address_role_type.zig").AddressRoleType;

/// The meta data information associated with the account.
pub const AccountMetaData = struct {
    /// The Amazon Web Services accounts name.
    account_name: ?[]const u8 = null,

    address: ?Address = null,

    /// Address roles associated with the account containing country code
    /// information.
    address_role_map: ?[]const aws.map.MapEntry(Jurisdiction) = null,

    /// The type of address associated with the legal profile.
    address_type: ?AddressRoleType = null,

    /// Seller information associated with the account.
    seller: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_name = "accountName",
        .address = "address",
        .address_role_map = "addressRoleMap",
        .address_type = "addressType",
        .seller = "seller",
    };
};
