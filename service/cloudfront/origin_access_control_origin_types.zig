const std = @import("std");

pub const OriginAccessControlOriginTypes = enum {
    s_3,
    mediastore,
    mediapackagev_2,
    lambda,

    pub const json_field_names = .{
        .s_3 = "s3",
        .mediastore = "mediastore",
        .mediapackagev_2 = "mediapackagev2",
        .lambda = "lambda",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s_3 => "s3",
            .mediastore => "mediastore",
            .mediapackagev_2 => "mediapackagev2",
            .lambda => "lambda",
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
