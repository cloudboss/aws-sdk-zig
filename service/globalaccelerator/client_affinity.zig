const std = @import("std");

pub const ClientAffinity = enum {
    none,
    source_ip,

    pub const json_field_names = .{
        .none = "NONE",
        .source_ip = "SOURCE_IP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .source_ip => "SOURCE_IP",
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
