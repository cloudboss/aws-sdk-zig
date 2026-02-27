/// A structure that contains information about one delivery destination policy.
pub const Policy = struct {
    /// The contents of the delivery destination policy.
    delivery_destination_policy: ?[]const u8,

    pub const json_field_names = .{
        .delivery_destination_policy = "deliveryDestinationPolicy",
    };
};
