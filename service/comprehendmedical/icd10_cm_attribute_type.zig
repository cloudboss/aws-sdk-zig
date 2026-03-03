const std = @import("std");

pub const ICD10CMAttributeType = enum {
    acuity,
    direction,
    system_organ_site,
    quality,
    quantity,
    time_to_dx_name,
    time_expression,

    pub const json_field_names = .{
        .acuity = "ACUITY",
        .direction = "DIRECTION",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .quality = "QUALITY",
        .quantity = "QUANTITY",
        .time_to_dx_name = "TIME_TO_DX_NAME",
        .time_expression = "TIME_EXPRESSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .acuity => "ACUITY",
            .direction => "DIRECTION",
            .system_organ_site => "SYSTEM_ORGAN_SITE",
            .quality => "QUALITY",
            .quantity => "QUANTITY",
            .time_to_dx_name => "TIME_TO_DX_NAME",
            .time_expression => "TIME_EXPRESSION",
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
