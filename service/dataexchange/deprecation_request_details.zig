/// Extra details specific to a deprecation type notification.
pub const DeprecationRequestDetails = struct {
    /// A datetime in the future when the data set will be deprecated.
    deprecation_at: i64,

    pub const json_field_names = .{
        .deprecation_at = "DeprecationAt",
    };
};
