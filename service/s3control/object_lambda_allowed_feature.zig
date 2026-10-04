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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
