const std = @import("std");

pub const ResourceType = enum {
    cfn_stack,
    resource_tag_value,

    pub const json_field_names = .{
        .cfn_stack = "CFN_STACK",
        .resource_tag_value = "RESOURCE_TAG_VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cfn_stack => "CFN_STACK",
            .resource_tag_value => "RESOURCE_TAG_VALUE",
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
