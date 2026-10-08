const TimeType = @import("time_type.zig").TimeType;

/// Specifies an expiration configuration.
pub const Expiration = struct {
    /// The time unit for the expiration value.
    type: TimeType,

    /// The numeric value of the expiration.
    value: i64,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
