const std = @import("std");

pub const IpamPoolAwsService = enum {
    ec_2,
    global_services,

    pub const json_field_names = .{
        .ec_2 = "ec2",
        .global_services = "global-services",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec_2 => "ec2",
            .global_services => "global-services",
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
