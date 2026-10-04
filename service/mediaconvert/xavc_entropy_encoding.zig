const std = @import("std");

/// Optional. Choose a specific entropy encoding mode only when you want to
/// override XAVC recommendations. If you choose the value auto, MediaConvert
/// uses the mode that the XAVC file format specifies given this output's
/// operating point.
pub const XavcEntropyEncoding = enum {
    auto,
    cabac,
    cavlc,

    pub const json_field_names = .{
        .auto = "AUTO",
        .cabac = "CABAC",
        .cavlc = "CAVLC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
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
