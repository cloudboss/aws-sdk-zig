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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
