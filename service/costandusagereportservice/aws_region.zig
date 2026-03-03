const std = @import("std");

/// The region of the S3 bucket that Amazon Web Services delivers the report
/// into.
pub const AWSRegion = enum {
    cape_town,
    hong_kong,
    mumbai,
    hyderabad,
    singapore,
    sydney,
    jakarta,
    tokyo,
    seoul,
    osaka,
    canada_central,
    frankfurt,
    zurich,
    ireland,
    london,
    paris,
    stockholm,
    milano,
    spain,
    uae,
    bahrain,
    sao_paulo,
    us_standard,
    ohio,
    northern_california,
    oregon,
    beijing,
    ningxia,

    pub const json_field_names = .{
        .cape_town = "af-south-1",
        .hong_kong = "ap-east-1",
        .mumbai = "ap-south-1",
        .hyderabad = "ap-south-2",
        .singapore = "ap-southeast-1",
        .sydney = "ap-southeast-2",
        .jakarta = "ap-southeast-3",
        .tokyo = "ap-northeast-1",
        .seoul = "ap-northeast-2",
        .osaka = "ap-northeast-3",
        .canada_central = "ca-central-1",
        .frankfurt = "eu-central-1",
        .zurich = "eu-central-2",
        .ireland = "eu-west-1",
        .london = "eu-west-2",
        .paris = "eu-west-3",
        .stockholm = "eu-north-1",
        .milano = "eu-south-1",
        .spain = "eu-south-2",
        .uae = "me-central-1",
        .bahrain = "me-south-1",
        .sao_paulo = "sa-east-1",
        .us_standard = "us-east-1",
        .ohio = "us-east-2",
        .northern_california = "us-west-1",
        .oregon = "us-west-2",
        .beijing = "cn-north-1",
        .ningxia = "cn-northwest-1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cape_town => "af-south-1",
            .hong_kong => "ap-east-1",
            .mumbai => "ap-south-1",
            .hyderabad => "ap-south-2",
            .singapore => "ap-southeast-1",
            .sydney => "ap-southeast-2",
            .jakarta => "ap-southeast-3",
            .tokyo => "ap-northeast-1",
            .seoul => "ap-northeast-2",
            .osaka => "ap-northeast-3",
            .canada_central => "ca-central-1",
            .frankfurt => "eu-central-1",
            .zurich => "eu-central-2",
            .ireland => "eu-west-1",
            .london => "eu-west-2",
            .paris => "eu-west-3",
            .stockholm => "eu-north-1",
            .milano => "eu-south-1",
            .spain => "eu-south-2",
            .uae => "me-central-1",
            .bahrain => "me-south-1",
            .sao_paulo => "sa-east-1",
            .us_standard => "us-east-1",
            .ohio => "us-east-2",
            .northern_california => "us-west-1",
            .oregon => "us-west-2",
            .beijing => "cn-north-1",
            .ningxia => "cn-northwest-1",
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
