const std = @import("std");

pub const DeploymentPatternVersionFilterKey = enum {
    deployment_pattern_version_name,

    pub const json_field_names = .{
        .deployment_pattern_version_name = "updateFromVersion",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deployment_pattern_version_name => "updateFromVersion",
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
