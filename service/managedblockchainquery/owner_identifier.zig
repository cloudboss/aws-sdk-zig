/// The container for the owner identifier.
pub const OwnerIdentifier = struct {
    /// The contract or wallet address for the owner.
    address: []const u8,

    pub const json_field_names = .{
        .address = "address",
    };
};
