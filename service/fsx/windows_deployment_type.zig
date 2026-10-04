const std = @import("std");

pub const WindowsDeploymentType = enum {
    multi_az_1,
    single_az_1,
    single_az_2,

    pub const json_field_names = .{
        .multi_az_1 = "MULTI_AZ_1",
        .single_az_1 = "SINGLE_AZ_1",
        .single_az_2 = "SINGLE_AZ_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_az_1 => "MULTI_AZ_1",
            .single_az_1 => "SINGLE_AZ_1",
            .single_az_2 => "SINGLE_AZ_2",
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
