const NielsenWatermarkTimezones = @import("nielsen_watermark_timezones.zig").NielsenWatermarkTimezones;

/// Nielsen Naes Ii Nw
pub const NielsenNaesIiNw = struct {
    /// Enter the check digit string for the watermark
    check_digit_string: []const u8,

    /// Enter the Nielsen Source ID (SID) to include in the watermark
    sid: f64,

    /// Choose the timezone for the time stamps in the watermark. If not provided,
    /// the timestamps will be in Coordinated Universal Time (UTC)
    timezone: ?NielsenWatermarkTimezones = null,

    pub const json_field_names = .{
        .check_digit_string = "CheckDigitString",
        .sid = "Sid",
        .timezone = "Timezone",
    };
};
