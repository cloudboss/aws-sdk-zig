const std = @import("std");

pub const EncodingProfile = enum {
    distribution_h264_default,
    contribution_h264_default,

    pub const json_field_names = .{
        .distribution_h264_default = "DISTRIBUTION_H264_DEFAULT",
        .contribution_h264_default = "CONTRIBUTION_H264_DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .distribution_h264_default => "DISTRIBUTION_H264_DEFAULT",
            .contribution_h264_default => "CONTRIBUTION_H264_DEFAULT",
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
