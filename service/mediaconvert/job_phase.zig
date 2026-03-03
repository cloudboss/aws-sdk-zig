const std = @import("std");

/// A job's phase can be PROBING, TRANSCODING OR UPLOADING
pub const JobPhase = enum {
    probing,
    transcoding,
    uploading,

    pub const json_field_names = .{
        .probing = "PROBING",
        .transcoding = "TRANSCODING",
        .uploading = "UPLOADING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .probing => "PROBING",
            .transcoding => "TRANSCODING",
            .uploading => "UPLOADING",
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
