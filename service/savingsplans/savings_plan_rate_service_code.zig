const std = @import("std");

pub const SavingsPlanRateServiceCode = enum {
    ec2,
    fargate,
    fargate_eks,
    lambda,
    sagemaker,
    rds,
    aurora,
    dynamodb,
    elasticache,
    docdb,
    neptune,
    timestream,
    mcs,
    dms,

    pub const json_field_names = .{
        .ec2 = "AmazonEC2",
        .fargate = "AmazonECS",
        .fargate_eks = "AmazonEKS",
        .lambda = "AWSLambda",
        .sagemaker = "AmazonSageMaker",
        .rds = "AmazonRDS",
        .aurora = "AuroraDSQL",
        .dynamodb = "AmazonDynamoDB",
        .elasticache = "AmazonElastiCache",
        .docdb = "AmazonDocDB",
        .neptune = "AmazonNeptune",
        .timestream = "AmazonTimestream",
        .mcs = "AmazonMCS",
        .dms = "AWSDatabaseMigrationSvc",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2 => "AmazonEC2",
            .fargate => "AmazonECS",
            .fargate_eks => "AmazonEKS",
            .lambda => "AWSLambda",
            .sagemaker => "AmazonSageMaker",
            .rds => "AmazonRDS",
            .aurora => "AuroraDSQL",
            .dynamodb => "AmazonDynamoDB",
            .elasticache => "AmazonElastiCache",
            .docdb => "AmazonDocDB",
            .neptune => "AmazonNeptune",
            .timestream => "AmazonTimestream",
            .mcs => "AmazonMCS",
            .dms => "AWSDatabaseMigrationSvc",
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
