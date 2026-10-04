const std = @import("std");

pub const ApplicationAttribute = enum {
    launch_parameters,
    working_directory,

    pub const json_field_names = .{
        .launch_parameters = "LAUNCH_PARAMETERS",
        .working_directory = "WORKING_DIRECTORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .launch_parameters => "LAUNCH_PARAMETERS",
            .working_directory => "WORKING_DIRECTORY",
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
