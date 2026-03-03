const std = @import("std");

pub const ESWarmPartitionInstanceType = enum {
    ultrawarm_1_medium_elasticsearch,
    ultrawarm_1_large_elasticsearch,

    pub const json_field_names = .{
        .ultrawarm_1_medium_elasticsearch = "ultrawarm1.medium.elasticsearch",
        .ultrawarm_1_large_elasticsearch = "ultrawarm1.large.elasticsearch",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ultrawarm_1_medium_elasticsearch => "ultrawarm1.medium.elasticsearch",
            .ultrawarm_1_large_elasticsearch => "ultrawarm1.large.elasticsearch",
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
