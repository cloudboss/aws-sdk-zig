const std = @import("std");

pub const ListHookResultsTargetType = enum {
    change_set,
    stack,
    resource,
    cloud_control,

    pub const json_field_names = .{
        .change_set = "CHANGE_SET",
        .stack = "STACK",
        .resource = "RESOURCE",
        .cloud_control = "CLOUD_CONTROL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .change_set => "CHANGE_SET",
            .stack => "STACK",
            .resource => "RESOURCE",
            .cloud_control => "CLOUD_CONTROL",
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
