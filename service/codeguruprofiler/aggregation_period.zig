const std = @import("std");

pub const AggregationPeriod = enum {
    /// Period of five minutes.
    pt5_m,
    /// Period of one hour.
    pt1_h,
    /// Period of one day.
    p1_d,

    pub const json_field_names = .{
        .pt5_m = "PT5M",
        .pt1_h = "PT1H",
        .p1_d = "P1D",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pt5_m => "PT5M",
            .pt1_h => "PT1H",
            .p1_d => "P1D",
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
