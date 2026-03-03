const std = @import("std");

pub const OpenSearchWarmPartitionInstanceType = enum {
    ultrawarm_1_medium_search,
    ultrawarm_1_large_search,
    ultrawarm_1_xlarge_search,

    pub const json_field_names = .{
        .ultrawarm_1_medium_search = "ultrawarm1.medium.search",
        .ultrawarm_1_large_search = "ultrawarm1.large.search",
        .ultrawarm_1_xlarge_search = "ultrawarm1.xlarge.search",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ultrawarm_1_medium_search => "ultrawarm1.medium.search",
            .ultrawarm_1_large_search => "ultrawarm1.large.search",
            .ultrawarm_1_xlarge_search => "ultrawarm1.xlarge.search",
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
