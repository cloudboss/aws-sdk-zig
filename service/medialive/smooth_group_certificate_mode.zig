const std = @import("std");

/// Smooth Group Certificate Mode
pub const SmoothGroupCertificateMode = enum {
    self_signed,
    verify_authenticity,

    pub const json_field_names = .{
        .self_signed = "SELF_SIGNED",
        .verify_authenticity = "VERIFY_AUTHENTICITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .self_signed => "SELF_SIGNED",
            .verify_authenticity => "VERIFY_AUTHENTICITY",
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
