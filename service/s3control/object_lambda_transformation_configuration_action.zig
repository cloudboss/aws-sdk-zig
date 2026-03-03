const std = @import("std");

pub const ObjectLambdaTransformationConfigurationAction = enum {
    get_object,
    head_object,
    list_objects,
    list_objects_v2,

    pub const json_field_names = .{
        .get_object = "GetObject",
        .head_object = "HeadObject",
        .list_objects = "ListObjects",
        .list_objects_v2 = "ListObjectsV2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get_object => "GetObject",
            .head_object => "HeadObject",
            .list_objects => "ListObjects",
            .list_objects_v2 => "ListObjectsV2",
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
