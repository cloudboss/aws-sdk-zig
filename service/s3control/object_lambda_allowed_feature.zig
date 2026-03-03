const std = @import("std");

pub const ObjectLambdaAllowedFeature = enum {
    get_object_range,
    get_object_part_number,
    head_object_range,
    head_object_part_number,

    pub const json_field_names = .{
        .get_object_range = "GetObject-Range",
        .get_object_part_number = "GetObject-PartNumber",
        .head_object_range = "HeadObject-Range",
        .head_object_part_number = "HeadObject-PartNumber",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get_object_range => "GetObject-Range",
            .get_object_part_number => "GetObject-PartNumber",
            .head_object_range => "HeadObject-Range",
            .head_object_part_number => "HeadObject-PartNumber",
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
