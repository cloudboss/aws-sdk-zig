const std = @import("std");

pub const ServiceNamespace = enum {
    ecs,
    emr,
    ec2,
    appstream,
    dynamodb,
    rds,
    sagemaker,
    custom_resource,
    comprehend,
    lambda,
    cassandra,
    kafka,
    elasticache,
    neptune,
    workspaces,

    pub const json_field_names = .{
        .ecs = "ecs",
        .emr = "elasticmapreduce",
        .ec2 = "ec2",
        .appstream = "appstream",
        .dynamodb = "dynamodb",
        .rds = "rds",
        .sagemaker = "sagemaker",
        .custom_resource = "custom-resource",
        .comprehend = "comprehend",
        .lambda = "lambda",
        .cassandra = "cassandra",
        .kafka = "kafka",
        .elasticache = "elasticache",
        .neptune = "neptune",
        .workspaces = "workspaces",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ecs => "ecs",
            .emr => "elasticmapreduce",
            .ec2 => "ec2",
            .appstream => "appstream",
            .dynamodb => "dynamodb",
            .rds => "rds",
            .sagemaker => "sagemaker",
            .custom_resource => "custom-resource",
            .comprehend => "comprehend",
            .lambda => "lambda",
            .cassandra => "cassandra",
            .kafka => "kafka",
            .elasticache => "elasticache",
            .neptune => "neptune",
            .workspaces => "workspaces",
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
