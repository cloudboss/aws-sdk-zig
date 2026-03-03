const std = @import("std");

pub const SSEType = enum {
    sse_ebs,
    sse_kms,
    none,

    pub const json_field_names = .{
        .sse_ebs = "sse-ebs",
        .sse_kms = "sse-kms",
        .none = "none",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sse_ebs => "sse-ebs",
            .sse_kms => "sse-kms",
            .none => "none",
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
