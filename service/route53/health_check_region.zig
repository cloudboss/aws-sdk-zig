const std = @import("std");

pub const HealthCheckRegion = enum {
    us_east_1,
    us_west_1,
    us_west_2,
    eu_west_1,
    ap_southeast_1,
    ap_southeast_2,
    ap_northeast_1,
    sa_east_1,

    pub const json_field_names = .{
        .us_east_1 = "us-east-1",
        .us_west_1 = "us-west-1",
        .us_west_2 = "us-west-2",
        .eu_west_1 = "eu-west-1",
        .ap_southeast_1 = "ap-southeast-1",
        .ap_southeast_2 = "ap-southeast-2",
        .ap_northeast_1 = "ap-northeast-1",
        .sa_east_1 = "sa-east-1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .us_east_1 => "us-east-1",
            .us_west_1 => "us-west-1",
            .us_west_2 => "us-west-2",
            .eu_west_1 => "eu-west-1",
            .ap_southeast_1 => "ap-southeast-1",
            .ap_southeast_2 => "ap-southeast-2",
            .ap_northeast_1 => "ap-northeast-1",
            .sa_east_1 => "sa-east-1",
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
