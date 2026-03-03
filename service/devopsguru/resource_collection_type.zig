const std = @import("std");

pub const ResourceCollectionType = enum {
    aws_cloud_formation,
    aws_service,
    aws_tags,

    pub const json_field_names = .{
        .aws_cloud_formation = "AWS_CLOUD_FORMATION",
        .aws_service = "AWS_SERVICE",
        .aws_tags = "AWS_TAGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_cloud_formation => "AWS_CLOUD_FORMATION",
            .aws_service => "AWS_SERVICE",
            .aws_tags => "AWS_TAGS",
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
