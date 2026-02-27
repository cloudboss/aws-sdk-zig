/// An address that is a member of an address list.
pub const SavedAddress = struct {
    /// The email or domain that constitutes the address.
    address: []const u8,

    /// The timestamp of when the address was added to the address list.
    created_timestamp: i64,

    pub const json_field_names = .{
        .address = "Address",
        .created_timestamp = "CreatedTimestamp",
    };
};
