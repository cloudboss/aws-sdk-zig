const std = @import("std");

pub const SavingsPlanProductType = enum {
    ec2,
    fargate,
    lambda,
    sagemaker,
    rds,
    dsql,
    dynamodb,
    elasticache,
    docdb,
    neptune,
    timestream,
    keyspaces,
    dms,
    opensearch,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .fargate = "Fargate",
        .lambda = "Lambda",
        .sagemaker = "SageMaker",
        .rds = "RDS",
        .dsql = "DSQL",
        .dynamodb = "DynamoDB",
        .elasticache = "ElastiCache",
        .docdb = "DocDB",
        .neptune = "Neptune",
        .timestream = "Timestream",
        .keyspaces = "Keyspaces",
        .dms = "DMS",
        .opensearch = "OpenSearch",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2 => "EC2",
            .fargate => "Fargate",
            .lambda => "Lambda",
            .sagemaker => "SageMaker",
            .rds => "RDS",
            .dsql => "DSQL",
            .dynamodb => "DynamoDB",
            .elasticache => "ElastiCache",
            .docdb => "DocDB",
            .neptune => "Neptune",
            .timestream => "Timestream",
            .keyspaces => "Keyspaces",
            .dms => "DMS",
            .opensearch => "OpenSearch",
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
