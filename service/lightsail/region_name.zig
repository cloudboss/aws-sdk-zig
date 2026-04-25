const std = @import("std");

pub const RegionName = enum {
    us_east_1,
    us_east_2,
    us_west_1,
    us_west_2,
    eu_west_1,
    eu_west_2,
    eu_west_3,
    eu_central_1,
    eu_north_1,
    ca_central_1,
    ap_south_1,
    ap_southeast_1,
    ap_southeast_2,
    ap_northeast_1,
    ap_northeast_2,
    ap_southeast_3,
    ap_southeast_5,

    pub const json_field_names = .{
        .us_east_1 = "us-east-1",
        .us_east_2 = "us-east-2",
        .us_west_1 = "us-west-1",
        .us_west_2 = "us-west-2",
        .eu_west_1 = "eu-west-1",
        .eu_west_2 = "eu-west-2",
        .eu_west_3 = "eu-west-3",
        .eu_central_1 = "eu-central-1",
        .eu_north_1 = "eu-north-1",
        .ca_central_1 = "ca-central-1",
        .ap_south_1 = "ap-south-1",
        .ap_southeast_1 = "ap-southeast-1",
        .ap_southeast_2 = "ap-southeast-2",
        .ap_northeast_1 = "ap-northeast-1",
        .ap_northeast_2 = "ap-northeast-2",
        .ap_southeast_3 = "ap-southeast-3",
        .ap_southeast_5 = "ap-southeast-5",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .us_east_1 => "us-east-1",
            .us_east_2 => "us-east-2",
            .us_west_1 => "us-west-1",
            .us_west_2 => "us-west-2",
            .eu_west_1 => "eu-west-1",
            .eu_west_2 => "eu-west-2",
            .eu_west_3 => "eu-west-3",
            .eu_central_1 => "eu-central-1",
            .eu_north_1 => "eu-north-1",
            .ca_central_1 => "ca-central-1",
            .ap_south_1 => "ap-south-1",
            .ap_southeast_1 => "ap-southeast-1",
            .ap_southeast_2 => "ap-southeast-2",
            .ap_northeast_1 => "ap-northeast-1",
            .ap_northeast_2 => "ap-northeast-2",
            .ap_southeast_3 => "ap-southeast-3",
            .ap_southeast_5 => "ap-southeast-5",
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
