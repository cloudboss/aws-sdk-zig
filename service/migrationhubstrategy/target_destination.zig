const std = @import("std");

pub const TargetDestination = enum {
    none_specified,
    aws_elastic_beanstalk,
    aws_fargate,
    amazon_elastic_cloud_compute,
    amazon_elastic_container_service,
    amazon_elastic_kubernetes_service,
    aurora_mysql,
    aurora_postgresql,
    amazon_rds_mysql,
    amazon_rds_postgresql,
    amazon_documentdb,
    amazon_dynamodb,
    amazon_rds,
    babelfish_aurora_postgresql,

    pub const json_field_names = .{
        .none_specified = "None specified",
        .aws_elastic_beanstalk = "AWS Elastic BeanStalk",
        .aws_fargate = "AWS Fargate",
        .amazon_elastic_cloud_compute = "Amazon Elastic Cloud Compute (EC2)",
        .amazon_elastic_container_service = "Amazon Elastic Container Service (ECS)",
        .amazon_elastic_kubernetes_service = "Amazon Elastic Kubernetes Service (EKS)",
        .aurora_mysql = "Aurora MySQL",
        .aurora_postgresql = "Aurora PostgreSQL",
        .amazon_rds_mysql = "Amazon Relational Database Service on MySQL",
        .amazon_rds_postgresql = "Amazon Relational Database Service on PostgreSQL",
        .amazon_documentdb = "Amazon DocumentDB",
        .amazon_dynamodb = "Amazon DynamoDB",
        .amazon_rds = "Amazon Relational Database Service",
        .babelfish_aurora_postgresql = "Babelfish for Aurora PostgreSQL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none_specified => "None specified",
            .aws_elastic_beanstalk => "AWS Elastic BeanStalk",
            .aws_fargate => "AWS Fargate",
            .amazon_elastic_cloud_compute => "Amazon Elastic Cloud Compute (EC2)",
            .amazon_elastic_container_service => "Amazon Elastic Container Service (ECS)",
            .amazon_elastic_kubernetes_service => "Amazon Elastic Kubernetes Service (EKS)",
            .aurora_mysql => "Aurora MySQL",
            .aurora_postgresql => "Aurora PostgreSQL",
            .amazon_rds_mysql => "Amazon Relational Database Service on MySQL",
            .amazon_rds_postgresql => "Amazon Relational Database Service on PostgreSQL",
            .amazon_documentdb => "Amazon DocumentDB",
            .amazon_dynamodb => "Amazon DynamoDB",
            .amazon_rds => "Amazon Relational Database Service",
            .babelfish_aurora_postgresql => "Babelfish for Aurora PostgreSQL",
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
