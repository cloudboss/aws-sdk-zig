const std = @import("std");

pub const LustreDeploymentType = enum {
    scratch_1,
    scratch_2,
    persistent_1,
    persistent_2,

    pub const json_field_names = .{
        .scratch_1 = "SCRATCH_1",
        .scratch_2 = "SCRATCH_2",
        .persistent_1 = "PERSISTENT_1",
        .persistent_2 = "PERSISTENT_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scratch_1 => "SCRATCH_1",
            .scratch_2 => "SCRATCH_2",
            .persistent_1 => "PERSISTENT_1",
            .persistent_2 => "PERSISTENT_2",
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
