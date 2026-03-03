const std = @import("std");

/// The `BatchGetMetricDataQuery` dimension name. This can be one of the
/// following:
///
/// * `EMAIL_IDENTITY` – The email identity used when sending messages.
///
/// * `CONFIGURATION_SET` – The configuration set used when sending messages
/// (if one was used).
///
/// * `ISP` – The recipient ISP (e.g. `Gmail`, `Yahoo`,
/// etc.).
pub const MetricDimensionName = enum {
    email_identity,
    configuration_set,
    isp,

    pub const json_field_names = .{
        .email_identity = "EMAIL_IDENTITY",
        .configuration_set = "CONFIGURATION_SET",
        .isp = "ISP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .email_identity => "EMAIL_IDENTITY",
            .configuration_set => "CONFIGURATION_SET",
            .isp => "ISP",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
