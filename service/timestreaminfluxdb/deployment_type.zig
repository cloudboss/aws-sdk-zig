const std = @import("std");

pub const DeploymentType = enum {
    single_az,
    with_multiaz_standby,

    pub const json_field_names = .{
        .single_az = "SINGLE_AZ",
        .with_multiaz_standby = "WITH_MULTIAZ_STANDBY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_az => "SINGLE_AZ",
            .with_multiaz_standby => "WITH_MULTIAZ_STANDBY",
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
