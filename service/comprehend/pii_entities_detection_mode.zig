const std = @import("std");

pub const PiiEntitiesDetectionMode = enum {
    only_redaction,
    only_offsets,

    pub const json_field_names = .{
        .only_redaction = "ONLY_REDACTION",
        .only_offsets = "ONLY_OFFSETS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .only_redaction => "ONLY_REDACTION",
            .only_offsets => "ONLY_OFFSETS",
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
