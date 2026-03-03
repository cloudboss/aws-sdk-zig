const std = @import("std");

pub const MarketingSource = enum {
    marketing_activity,
    none,

    pub const json_field_names = .{
        .marketing_activity = "Marketing Activity",
        .none = "None",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .marketing_activity => "Marketing Activity",
            .none => "None",
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
