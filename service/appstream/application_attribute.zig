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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
