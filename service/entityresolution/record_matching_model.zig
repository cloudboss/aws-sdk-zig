const std = @import("std");

pub const RecordMatchingModel = enum {
    one_source_to_one_target,
    many_source_to_one_target,

    pub const json_field_names = .{
        .one_source_to_one_target = "ONE_SOURCE_TO_ONE_TARGET",
        .many_source_to_one_target = "MANY_SOURCE_TO_ONE_TARGET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_source_to_one_target => "ONE_SOURCE_TO_ONE_TARGET",
            .many_source_to_one_target => "MANY_SOURCE_TO_ONE_TARGET",
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
