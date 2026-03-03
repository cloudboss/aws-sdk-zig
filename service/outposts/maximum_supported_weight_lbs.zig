const std = @import("std");

pub const MaximumSupportedWeightLbs = enum {
    no_limit,
    max_1400_lbs,
    max_1600_lbs,
    max_1800_lbs,
    max_2000_lbs,

    pub const json_field_names = .{
        .no_limit = "NO_LIMIT",
        .max_1400_lbs = "MAX_1400_LBS",
        .max_1600_lbs = "MAX_1600_LBS",
        .max_1800_lbs = "MAX_1800_LBS",
        .max_2000_lbs = "MAX_2000_LBS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_limit => "NO_LIMIT",
            .max_1400_lbs => "MAX_1400_LBS",
            .max_1600_lbs => "MAX_1600_LBS",
            .max_1800_lbs => "MAX_1800_LBS",
            .max_2000_lbs => "MAX_2000_LBS",
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
