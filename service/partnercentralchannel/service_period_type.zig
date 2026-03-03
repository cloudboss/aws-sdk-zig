const std = @import("std");

pub const ServicePeriodType = enum {
    minimum_notice_period,
    fixed_commitment_period,

    pub const json_field_names = .{
        .minimum_notice_period = "MINIMUM_NOTICE_PERIOD",
        .fixed_commitment_period = "FIXED_COMMITMENT_PERIOD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .minimum_notice_period => "MINIMUM_NOTICE_PERIOD",
            .fixed_commitment_period => "FIXED_COMMITMENT_PERIOD",
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
