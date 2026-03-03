const std = @import("std");

pub const ActionSubType = enum {
    stop_ec2,
    stop_rds,

    pub const json_field_names = .{
        .stop_ec2 = "STOP_EC2_INSTANCES",
        .stop_rds = "STOP_RDS_INSTANCES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stop_ec2 => "STOP_EC2_INSTANCES",
            .stop_rds => "STOP_RDS_INSTANCES",
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
