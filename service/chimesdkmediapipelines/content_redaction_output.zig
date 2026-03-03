const std = @import("std");

pub const ContentRedactionOutput = enum {
    redacted,
    redacted_and_unredacted,

    pub const json_field_names = .{
        .redacted = "redacted",
        .redacted_and_unredacted = "redacted_and_unredacted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .redacted => "redacted",
            .redacted_and_unredacted => "redacted_and_unredacted",
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
