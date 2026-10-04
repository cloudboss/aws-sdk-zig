const std = @import("std");

/// Udp Timed Metadata Id3 Frame
pub const UdpTimedMetadataId3Frame = enum {
    none,
    priv,
    tdrl,

    pub const json_field_names = .{
        .none = "NONE",
        .priv = "PRIV",
        .tdrl = "TDRL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .priv => "PRIV",
            .tdrl => "TDRL",
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
