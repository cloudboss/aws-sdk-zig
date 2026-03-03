const std = @import("std");

pub const AwsLogSourceName = enum {
    route53,
    vpc_flow,
    sh_findings,
    cloud_trail_mgmt,
    lambda_execution,
    s3_data,
    eks_audit,
    waf,

    pub const json_field_names = .{
        .route53 = "ROUTE53",
        .vpc_flow = "VPC_FLOW",
        .sh_findings = "SH_FINDINGS",
        .cloud_trail_mgmt = "CLOUD_TRAIL_MGMT",
        .lambda_execution = "LAMBDA_EXECUTION",
        .s3_data = "S3_DATA",
        .eks_audit = "EKS_AUDIT",
        .waf = "WAF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .route53 => "ROUTE53",
            .vpc_flow => "VPC_FLOW",
            .sh_findings => "SH_FINDINGS",
            .cloud_trail_mgmt => "CLOUD_TRAIL_MGMT",
            .lambda_execution => "LAMBDA_EXECUTION",
            .s3_data => "S3_DATA",
            .eks_audit => "EKS_AUDIT",
            .waf => "WAF",
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
