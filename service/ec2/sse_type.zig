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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
