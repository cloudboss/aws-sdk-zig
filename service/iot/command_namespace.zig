const std = @import("std");

pub const CommandNamespace = enum {
    aws_io_t,
    aws_io_t_fleet_wise,

    pub const json_field_names = .{
        .aws_io_t = "AWS-IoT",
        .aws_io_t_fleet_wise = "AWS-IoT-FleetWise",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_io_t => "AWS-IoT",
            .aws_io_t_fleet_wise => "AWS-IoT-FleetWise",
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
