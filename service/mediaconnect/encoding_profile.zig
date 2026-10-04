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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
