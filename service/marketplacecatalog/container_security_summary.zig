/// The details of the resource assessed under the Container Security framework.
pub const ContainerSecuritySummary = struct {
    /// The unique ID of the delivery option that was evaluated.
    delivery_option_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_option_id = "DeliveryOptionId",
    };
};
