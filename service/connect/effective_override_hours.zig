const OverrideHour = @import("override_hour.zig").OverrideHour;

/// Information about the hours of operation overrides which contribute to
/// effective hours of operations.
pub const EffectiveOverrideHours = struct {
    /// The date that the hours of operation override applies to.
    date: ?[]const u8 = null,

    /// Information about the hours of operation overrides that apply to a specific
    /// date.
    override_hours: ?[]const OverrideHour = null,

    pub const json_field_names = .{
        .date = "Date",
        .override_hours = "OverrideHours",
    };
};
