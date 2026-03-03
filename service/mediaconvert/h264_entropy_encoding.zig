const std = @import("std");

/// Entropy encoding mode. Use CABAC (must be in Main or High profile) or CAVLC.
pub const H264EntropyEncoding = enum {
    cabac,
    cavlc,

    pub const json_field_names = .{
        .cabac = "CABAC",
        .cavlc = "CAVLC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cabac => "CABAC",
            .cavlc => "CAVLC",
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
