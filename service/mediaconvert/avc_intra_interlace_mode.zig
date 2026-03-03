const std = @import("std");

/// Choose the scan line type for the output. Keep the default value,
/// Progressive to create a progressive output, regardless of the scan type of
/// your input. Use Top field first or Bottom field first to create an output
/// that's interlaced with the same field polarity throughout. Use Follow,
/// default top or Follow, default bottom to produce outputs with the same field
/// polarity as the source. For jobs that have multiple inputs, the output field
/// polarity might change over the course of the output. Follow behavior depends
/// on the input scan type. If the source is interlaced, the output will be
/// interlaced with the same polarity as the source. If the source is
/// progressive, the output will be interlaced with top field bottom field
/// first, depending on which of the Follow options you choose.
pub const AvcIntraInterlaceMode = enum {
    progressive,
    top_field,
    bottom_field,
    follow_top_field,
    follow_bottom_field,

    pub const json_field_names = .{
        .progressive = "PROGRESSIVE",
        .top_field = "TOP_FIELD",
        .bottom_field = "BOTTOM_FIELD",
        .follow_top_field = "FOLLOW_TOP_FIELD",
        .follow_bottom_field = "FOLLOW_BOTTOM_FIELD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .progressive => "PROGRESSIVE",
            .top_field => "TOP_FIELD",
            .bottom_field => "BOTTOM_FIELD",
            .follow_top_field => "FOLLOW_TOP_FIELD",
            .follow_bottom_field => "FOLLOW_BOTTOM_FIELD",
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
