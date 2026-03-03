const std = @import("std");

/// Specify the AVC-Intra class of your output. The AVC-Intra class selection
/// determines the output video bit rate depending on the frame rate of the
/// output. Outputs with higher class values have higher bitrates and improved
/// image quality. Note that for Class 4K/2K, MediaConvert supports only 4:2:2
/// chroma subsampling.
pub const AvcIntraClass = enum {
    class_50,
    class_100,
    class_200,
    class_4_k_2_k,

    pub const json_field_names = .{
        .class_50 = "CLASS_50",
        .class_100 = "CLASS_100",
        .class_200 = "CLASS_200",
        .class_4_k_2_k = "CLASS_4K_2K",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .class_50 => "CLASS_50",
            .class_100 => "CLASS_100",
            .class_200 => "CLASS_200",
            .class_4_k_2_k => "CLASS_4K_2K",
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
