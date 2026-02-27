/// The container for the owner information to filter by.
pub const OwnerFilter = struct {
    /// The contract or wallet address.
    address: []const u8,

    pub const json_field_names = .{
        .address = "address",
    };
};
