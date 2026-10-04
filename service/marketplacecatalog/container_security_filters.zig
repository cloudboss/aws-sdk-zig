/// Filters that apply to assessments performed against the Container Security
/// framework.
pub const ContainerSecurityFilters = struct {
    /// The unique ID of the delivery option whose Container Security assessments
    /// you want
    /// to list.
    delivery_option_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_option_id = "DeliveryOptionId",
    };
};
