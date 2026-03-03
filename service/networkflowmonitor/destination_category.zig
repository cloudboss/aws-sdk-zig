const std = @import("std");

pub const DestinationCategory = enum {
    intra_az,
    inter_az,
    inter_vpc,
    unclassified,
    amazon_s3,
    amazon_dynamodb,
    inter_region,

    pub const json_field_names = .{
        .intra_az = "INTRA_AZ",
        .inter_az = "INTER_AZ",
        .inter_vpc = "INTER_VPC",
        .unclassified = "UNCLASSIFIED",
        .amazon_s3 = "AMAZON_S3",
        .amazon_dynamodb = "AMAZON_DYNAMODB",
        .inter_region = "INTER_REGION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .intra_az => "INTRA_AZ",
            .inter_az => "INTER_AZ",
            .inter_vpc => "INTER_VPC",
            .unclassified => "UNCLASSIFIED",
            .amazon_s3 => "AMAZON_S3",
            .amazon_dynamodb => "AMAZON_DYNAMODB",
            .inter_region => "INTER_REGION",
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
