const std = @import("std");

pub const DataSourceType = enum {
    /// Amazon OpenSearch Service
    amazon_opensearch_service,
    /// CloudWatch Logs
    cloudwatch,
    /// Managed Prometheus
    prometheus,
    /// X-Ray
    xray,
    /// Timestream
    timestream,
    /// IoT SiteWise
    sitewise,
    /// Amazon Athena
    athena,
    /// Redshift
    redshift,
    /// IoT TwinMaker
    twinmaker,

    pub const json_field_names = .{
        .amazon_opensearch_service = "AMAZON_OPENSEARCH_SERVICE",
        .cloudwatch = "CLOUDWATCH",
        .prometheus = "PROMETHEUS",
        .xray = "XRAY",
        .timestream = "TIMESTREAM",
        .sitewise = "SITEWISE",
        .athena = "ATHENA",
        .redshift = "REDSHIFT",
        .twinmaker = "TWINMAKER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_opensearch_service => "AMAZON_OPENSEARCH_SERVICE",
            .cloudwatch => "CLOUDWATCH",
            .prometheus => "PROMETHEUS",
            .xray => "XRAY",
            .timestream => "TIMESTREAM",
            .sitewise => "SITEWISE",
            .athena => "ATHENA",
            .redshift => "REDSHIFT",
            .twinmaker => "TWINMAKER",
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
