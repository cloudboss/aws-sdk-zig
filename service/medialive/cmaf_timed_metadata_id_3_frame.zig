const std = @import("std");

/// Cmaf Timed Metadata Id3 Frame
pub const CmafTimedMetadataId3Frame = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
