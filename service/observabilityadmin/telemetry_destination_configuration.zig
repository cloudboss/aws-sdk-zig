const CloudtrailParameters = @import("cloudtrail_parameters.zig").CloudtrailParameters;
const DestinationType = @import("destination_type.zig").DestinationType;
const ELBLoadBalancerLoggingParameters = @import("elb_load_balancer_logging_parameters.zig").ELBLoadBalancerLoggingParameters;
const LogDeliveryParameters = @import("log_delivery_parameters.zig").LogDeliveryParameters;
const VPCFlowLogParameters = @import("vpc_flow_log_parameters.zig").VPCFlowLogParameters;
const WAFLoggingParameters = @import("waf_logging_parameters.zig").WAFLoggingParameters;

/// Configuration specifying where and how telemetry data should be delivered
/// for Amazon Web Services resources.
pub const TelemetryDestinationConfiguration = struct {
    /// Configuration parameters specific to Amazon Web Services CloudTrail when
    /// CloudTrail is the source type.
    cloudtrail_parameters: ?CloudtrailParameters = null,

    /// The pattern used to generate the destination path or name, supporting macros
    /// like <resourceId> and <accountId>.
    destination_pattern: ?[]const u8 = null,

    /// The type of destination for the telemetry data (e.g., "Amazon CloudWatch
    /// Logs", "S3").
    destination_type: ?DestinationType = null,

    /// Configuration parameters specific to ELB load balancer logging when ELB is
    /// the resource type.
    elb_load_balancer_logging_parameters: ?ELBLoadBalancerLoggingParameters = null,

    /// Configuration parameters specific to Amazon Bedrock AgentCore logging when
    /// Amazon Bedrock AgentCore is the resource type.
    log_delivery_parameters: ?LogDeliveryParameters = null,

    /// The number of days to retain the telemetry data in the destination.
    retention_in_days: ?i32 = null,

    /// Configuration parameters specific to VPC Flow Logs when VPC is the resource
    /// type.
    vpc_flow_log_parameters: ?VPCFlowLogParameters = null,

    /// Configuration parameters specific to WAF logging when WAF is the resource
    /// type.
    waf_logging_parameters: ?WAFLoggingParameters = null,

    pub const json_field_names = .{
        .cloudtrail_parameters = "CloudtrailParameters",
        .destination_pattern = "DestinationPattern",
        .destination_type = "DestinationType",
        .elb_load_balancer_logging_parameters = "ELBLoadBalancerLoggingParameters",
        .log_delivery_parameters = "LogDeliveryParameters",
        .retention_in_days = "RetentionInDays",
        .vpc_flow_log_parameters = "VPCFlowLogParameters",
        .waf_logging_parameters = "WAFLoggingParameters",
    };
};
