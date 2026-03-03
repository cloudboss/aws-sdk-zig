const std = @import("std");

pub const ScanResultStatus = enum {
    no_threats_found,
    threats_found,

    pub const json_field_names = .{
        .no_threats_found = "NO_THREATS_FOUND",
        .threats_found = "THREATS_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_threats_found => "NO_THREATS_FOUND",
            .threats_found => "THREATS_FOUND",
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
