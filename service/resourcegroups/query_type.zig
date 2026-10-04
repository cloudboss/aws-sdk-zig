const std = @import("std");

pub const QueryType = enum {
    tag_filters_1_0,
    cloudformation_stack_1_0,

    pub const json_field_names = .{
        .tag_filters_1_0 = "TAG_FILTERS_1_0",
        .cloudformation_stack_1_0 = "CLOUDFORMATION_STACK_1_0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tag_filters_1_0 => "TAG_FILTERS_1_0",
            .cloudformation_stack_1_0 => "CLOUDFORMATION_STACK_1_0",
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
