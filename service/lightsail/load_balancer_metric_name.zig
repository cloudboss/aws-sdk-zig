pub const LoadBalancerMetricName = enum {
    client_tls_negotiation_error_count,
    healthy_host_count,
    unhealthy_host_count,
    http_code_lb_4_xx_count,
    http_code_lb_5_xx_count,
    http_code_instance_2_xx_count,
    http_code_instance_3_xx_count,
    http_code_instance_4_xx_count,
    http_code_instance_5_xx_count,
    instance_response_time,
    rejected_connection_count,
    request_count,

    pub const json_field_names = .{
        .client_tls_negotiation_error_count = "ClientTLSNegotiationErrorCount",
        .healthy_host_count = "HealthyHostCount",
        .unhealthy_host_count = "UnhealthyHostCount",
        .http_code_lb_4_xx_count = "HTTPCode_LB_4XX_Count",
        .http_code_lb_5_xx_count = "HTTPCode_LB_5XX_Count",
        .http_code_instance_2_xx_count = "HTTPCode_Instance_2XX_Count",
        .http_code_instance_3_xx_count = "HTTPCode_Instance_3XX_Count",
        .http_code_instance_4_xx_count = "HTTPCode_Instance_4XX_Count",
        .http_code_instance_5_xx_count = "HTTPCode_Instance_5XX_Count",
        .instance_response_time = "InstanceResponseTime",
        .rejected_connection_count = "RejectedConnectionCount",
        .request_count = "RequestCount",
    };
};
