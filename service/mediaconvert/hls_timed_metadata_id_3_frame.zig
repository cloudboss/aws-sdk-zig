const std = @import("std");

/// Specify the type of the ID3 frame to use for ID3 timestamps in your output.
/// To include ID3 timestamps: Specify PRIV or TDRL and set ID3 metadata to
/// Passthrough. To exclude ID3 timestamps: Set ID3 timestamp frame type to
/// None.
pub const HlsTimedMetadataId3Frame = enum {
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
