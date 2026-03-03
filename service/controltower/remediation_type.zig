const std = @import("std");

pub const RemediationType = enum {
    inheritance_drift,

    pub const json_field_names = .{
        .inheritance_drift = "INHERITANCE_DRIFT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inheritance_drift => "INHERITANCE_DRIFT",
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
