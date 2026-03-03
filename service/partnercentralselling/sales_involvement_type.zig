const std = @import("std");

pub const SalesInvolvementType = enum {
    for_visibility_only,
    co_sell,

    pub const json_field_names = .{
        .for_visibility_only = "For Visibility Only",
        .co_sell = "Co-Sell",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .for_visibility_only => "For Visibility Only",
            .co_sell => "Co-Sell",
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
