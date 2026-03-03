/// Filtering options for ListMembersOfAddressList operation.
pub const AddressFilter = struct {
    /// Filter to limit the results to addresses having the provided prefix.
    address_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .address_prefix = "AddressPrefix",
    };
};
