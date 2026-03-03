const std = @import("std");

pub const OntapDeploymentType = enum {
    multi_az_1,
    single_az_1,
    single_az_2,
    multi_az_2,

    pub const json_field_names = .{
        .multi_az_1 = "MULTI_AZ_1",
        .single_az_1 = "SINGLE_AZ_1",
        .single_az_2 = "SINGLE_AZ_2",
        .multi_az_2 = "MULTI_AZ_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_az_1 => "MULTI_AZ_1",
            .single_az_1 => "SINGLE_AZ_1",
            .single_az_2 => "SINGLE_AZ_2",
            .multi_az_2 => "MULTI_AZ_2",
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
