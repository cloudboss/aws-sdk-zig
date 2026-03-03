const std = @import("std");

pub const BucketLocationConstraint = enum {
    eu,
    eu_west_1,
    us_west_1,
    us_west_2,
    ap_south_1,
    ap_southeast_1,
    ap_southeast_2,
    ap_northeast_1,
    sa_east_1,
    cn_north_1,
    eu_central_1,

    pub const json_field_names = .{
        .eu = "EU",
        .eu_west_1 = "eu-west-1",
        .us_west_1 = "us-west-1",
        .us_west_2 = "us-west-2",
        .ap_south_1 = "ap-south-1",
        .ap_southeast_1 = "ap-southeast-1",
        .ap_southeast_2 = "ap-southeast-2",
        .ap_northeast_1 = "ap-northeast-1",
        .sa_east_1 = "sa-east-1",
        .cn_north_1 = "cn-north-1",
        .eu_central_1 = "eu-central-1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eu => "EU",
            .eu_west_1 => "eu-west-1",
            .us_west_1 => "us-west-1",
            .us_west_2 => "us-west-2",
            .ap_south_1 => "ap-south-1",
            .ap_southeast_1 => "ap-southeast-1",
            .ap_southeast_2 => "ap-southeast-2",
            .ap_northeast_1 => "ap-northeast-1",
            .sa_east_1 => "sa-east-1",
            .cn_north_1 => "cn-north-1",
            .eu_central_1 => "eu-central-1",
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
