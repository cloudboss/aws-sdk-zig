const std = @import("std");

/// 'With AV1 outputs, for rate control mode, MediaConvert supports only
/// quality-defined variable bitrate (QVBR). You can''t use CBR or VBR.'
pub const Av1RateControlMode = enum {
    qvbr,

    pub const json_field_names = .{
        .qvbr = "QVBR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .qvbr => "QVBR",
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
