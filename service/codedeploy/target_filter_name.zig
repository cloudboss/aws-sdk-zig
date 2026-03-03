const std = @import("std");

pub const TargetFilterName = enum {
    target_status,
    server_instance_label,

    pub const json_field_names = .{
        .target_status = "TargetStatus",
        .server_instance_label = "ServerInstanceLabel",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .target_status => "TargetStatus",
            .server_instance_label => "ServerInstanceLabel",
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
