const std = @import("std");

pub const VoiceConnectorAwsRegion = enum {
    us_east_1,
    us_west_2,
    ca_central_1,
    eu_central_1,
    eu_west_1,
    eu_west_2,
    ap_northeast_2,
    ap_northeast_1,
    ap_southeast_1,
    ap_southeast_2,

    pub const json_field_names = .{
        .us_east_1 = "us-east-1",
        .us_west_2 = "us-west-2",
        .ca_central_1 = "ca-central-1",
        .eu_central_1 = "eu-central-1",
        .eu_west_1 = "eu-west-1",
        .eu_west_2 = "eu-west-2",
        .ap_northeast_2 = "ap-northeast-2",
        .ap_northeast_1 = "ap-northeast-1",
        .ap_southeast_1 = "ap-southeast-1",
        .ap_southeast_2 = "ap-southeast-2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .us_east_1 => "us-east-1",
            .us_west_2 => "us-west-2",
            .ca_central_1 => "ca-central-1",
            .eu_central_1 => "eu-central-1",
            .eu_west_1 => "eu-west-1",
            .eu_west_2 => "eu-west-2",
            .ap_northeast_2 => "ap-northeast-2",
            .ap_northeast_1 => "ap-northeast-1",
            .ap_southeast_1 => "ap-southeast-1",
            .ap_southeast_2 => "ap-southeast-2",
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
