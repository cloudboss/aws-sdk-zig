const std = @import("std");

pub const DeploymentComponentUpdatePolicyAction = enum {
    notify_components,
    skip_notify_components,

    pub const json_field_names = .{
        .notify_components = "NOTIFY_COMPONENTS",
        .skip_notify_components = "SKIP_NOTIFY_COMPONENTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .notify_components => "NOTIFY_COMPONENTS",
            .skip_notify_components => "SKIP_NOTIFY_COMPONENTS",
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
