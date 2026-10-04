/// Filters that apply to assessments performed against the AMI Security
/// framework.
pub const AMISecurityFilters = struct {
    /// The unique ID of the delivery option whose AMI Security assessments you want
    /// to
    /// list.
    delivery_option_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_option_id = "DeliveryOptionId",
    };
};
