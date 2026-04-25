const std = @import("std");

pub const QuotaShareResourceSharingStrategy = enum {
    reserve,
    lend,
    lend_and_borrow,

    pub const json_field_names = .{
        .reserve = "RESERVE",
        .lend = "LEND",
        .lend_and_borrow = "LEND_AND_BORROW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reserve => "RESERVE",
            .lend => "LEND",
            .lend_and_borrow => "LEND_AND_BORROW",
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
