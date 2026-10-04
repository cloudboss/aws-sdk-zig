const std = @import("std");

pub const Timing = enum {
    on_acceptance,
    scheduled,
    billing_period,

    pub const json_field_names = .{
        .on_acceptance = "ON_ACCEPTANCE",
        .scheduled = "SCHEDULED",
        .billing_period = "BILLING_PERIOD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_acceptance => "ON_ACCEPTANCE",
            .scheduled => "SCHEDULED",
            .billing_period => "BILLING_PERIOD",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
