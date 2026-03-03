const std = @import("std");

/// Units for duration, e.g. 'MONTHS'
pub const OfferingDurationUnits = enum {
    months,

    pub const json_field_names = .{
        .months = "MONTHS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .months => "MONTHS",
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
