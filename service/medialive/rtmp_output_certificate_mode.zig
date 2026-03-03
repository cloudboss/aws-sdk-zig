const std = @import("std");

/// Rtmp Output Certificate Mode
pub const RtmpOutputCertificateMode = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
