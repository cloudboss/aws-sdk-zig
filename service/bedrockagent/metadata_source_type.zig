const std = @import("std");

pub const MetadataSourceType = enum {
    in_line_attribute,
    s3_location,

    pub const json_field_names = .{
        .in_line_attribute = "IN_LINE_ATTRIBUTE",
        .s3_location = "S3_LOCATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_line_attribute => "IN_LINE_ATTRIBUTE",
            .s3_location => "S3_LOCATION",
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
