const std = @import("std");

pub const NumberType = enum {
    short_code,
    long_code,
    toll_free,
    ten_dlc,
    simulator,

    pub const json_field_names = .{
        .short_code = "SHORT_CODE",
        .long_code = "LONG_CODE",
        .toll_free = "TOLL_FREE",
        .ten_dlc = "TEN_DLC",
        .simulator = "SIMULATOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .short_code => "SHORT_CODE",
            .long_code => "LONG_CODE",
            .toll_free => "TOLL_FREE",
            .ten_dlc => "TEN_DLC",
            .simulator => "SIMULATOR",
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
