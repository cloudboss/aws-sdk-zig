const std = @import("std");

/// When you set Compatibility mapping to Duplicate Stream, DolbyVision streams
/// that have a backward compatible base layer (e.g., DolbyVision 8.1) will
/// cause a duplicate stream to be signaled in the manifest as a duplicate
/// stream. When you set Compatibility mapping to Supplemntal Codecs,
/// DolbyVision streams that have a backward compatible base layer (e.g.,
/// DolbyVision 8.1) will cause the associate stream in the manifest to include
/// a SUPPLEMENTAL_CODECS property.
pub const DolbyVisionCompatibility = enum {
    duplicate_stream,
    supplemental_codecs,

    pub const json_field_names = .{
        .duplicate_stream = "DUPLICATE_STREAM",
        .supplemental_codecs = "SUPPLEMENTAL_CODECS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .duplicate_stream => "DUPLICATE_STREAM",
            .supplemental_codecs => "SUPPLEMENTAL_CODECS",
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
