const std = @import("std");

/// Indicates that HDR10+ (SMPTE ST 2094-40) dynamic metadata was detected in
/// the HEVC bitstream. Present only when detected.
pub const Hdr10PlusPresence = enum {
    present,

    pub const json_field_names = .{
        .present = "PRESENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .present => "PRESENT",
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
