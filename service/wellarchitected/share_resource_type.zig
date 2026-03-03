const std = @import("std");

pub const ShareResourceType = enum {
    workload,
    lens,
    profile,
    template,

    pub const json_field_names = .{
        .workload = "WORKLOAD",
        .lens = "LENS",
        .profile = "PROFILE",
        .template = "TEMPLATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .workload => "WORKLOAD",
            .lens => "LENS",
            .profile => "PROFILE",
            .template => "TEMPLATE",
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
