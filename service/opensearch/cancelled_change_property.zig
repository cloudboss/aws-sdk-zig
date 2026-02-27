/// A property change that was cancelled for an Amazon OpenSearch Service
/// domain.
pub const CancelledChangeProperty = struct {
    /// The current value of the property, after the change was cancelled.
    active_value: ?[]const u8,

    /// The pending value of the property that was cancelled. This would have been
    /// the
    /// eventual value of the property if the chance had not been cancelled.
    cancelled_value: ?[]const u8,

    /// The name of the property whose change was cancelled.
    property_name: ?[]const u8,

    pub const json_field_names = .{
        .active_value = "ActiveValue",
        .cancelled_value = "CancelledValue",
        .property_name = "PropertyName",
    };
};
