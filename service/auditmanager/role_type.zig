const std = @import("std");

pub const RoleType = enum {
    process_owner,
    resource_owner,

    pub const json_field_names = .{
        .process_owner = "PROCESS_OWNER",
        .resource_owner = "RESOURCE_OWNER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .process_owner => "PROCESS_OWNER",
            .resource_owner => "RESOURCE_OWNER",
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
