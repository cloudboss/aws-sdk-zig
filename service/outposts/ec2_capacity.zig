/// Information about EC2 capacity.
pub const EC2Capacity = struct {
    /// The family of the EC2 capacity.
    family: ?[]const u8 = null,

    /// The maximum size of the EC2 capacity.
    max_size: ?[]const u8 = null,

    /// The quantity of the EC2 capacity.
    quantity: ?[]const u8 = null,

    pub const json_field_names = .{
        .family = "Family",
        .max_size = "MaxSize",
        .quantity = "Quantity",
    };
};
