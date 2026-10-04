const std = @import("std");

/// Hls Codec Specification
pub const HlsCodecSpecification = enum {
    rfc_4281,
    rfc_6381,

    pub const json_field_names = .{
        .rfc_4281 = "RFC_4281",
        .rfc_6381 = "RFC_6381",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rfc_4281 => "RFC_4281",
            .rfc_6381 => "RFC_6381",
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
