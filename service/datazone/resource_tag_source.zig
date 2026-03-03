const std = @import("std");

pub const ResourceTagSource = enum {
    project,
    project_profile,

    pub const json_field_names = .{
        .project = "PROJECT",
        .project_profile = "PROJECT_PROFILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .project => "PROJECT",
            .project_profile => "PROJECT_PROFILE",
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
