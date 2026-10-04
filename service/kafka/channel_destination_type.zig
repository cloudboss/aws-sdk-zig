const std = @import("std");

/// The type of destination configured for the channel.
pub const ChannelDestinationType = enum {
    iceberg,
    s3,

    pub const json_field_names = .{
        .iceberg = "ICEBERG",
        .s3 = "S3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iceberg => "ICEBERG",
            .s3 => "S3",
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
