const std = @import("std");

pub const ExposureImpact = enum {
    reduces,
    resolves,
    unchanged,

    pub const json_field_names = .{
        .reduces = "Reduces",
        .resolves = "Resolves",
        .unchanged = "Unchanged",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reduces => "Reduces",
            .resolves => "Resolves",
            .unchanged => "Unchanged",
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
