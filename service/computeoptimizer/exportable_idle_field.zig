const std = @import("std");

pub const ExportableIdleField = enum {
    account_id,
    resource_arn,
    resource_id,
    resource_type,
    last_refresh_timestamp,
    lookback_period_in_days,
    savings_opportunity,
    savings_opportunity_after_discount,
    utilization_metrics_cpu_maximum,
    utilization_metrics_memory_maximum,
    utilization_metrics_network_out_bytes_per_second_maximum,
    utilization_metrics_network_in_bytes_per_second_maximum,
    utilization_metrics_database_connections_maximum,
    utilization_metrics_ebs_volume_read_iops_maximum,
    utilization_metrics_ebs_volume_write_iops_maximum,
    utilization_metrics_volume_read_ops_per_second_maximum,
    utilization_metrics_volume_write_ops_per_second_maximum,
    utilization_metrics_active_connection_count_maximum,
    utilization_metrics_packets_in_from_source_maximum,
    utilization_metrics_packets_in_from_destination_maximum,
    finding,
    finding_description,
    tags,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .last_refresh_timestamp = "LastRefreshTimestamp",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .savings_opportunity = "SavingsOpportunity",
        .savings_opportunity_after_discount = "SavingsOpportunityAfterDiscount",
        .utilization_metrics_cpu_maximum = "UtilizationMetricsCpuMaximum",
        .utilization_metrics_memory_maximum = "UtilizationMetricsMemoryMaximum",
        .utilization_metrics_network_out_bytes_per_second_maximum = "UtilizationMetricsNetworkOutBytesPerSecondMaximum",
        .utilization_metrics_network_in_bytes_per_second_maximum = "UtilizationMetricsNetworkInBytesPerSecondMaximum",
        .utilization_metrics_database_connections_maximum = "UtilizationMetricsDatabaseConnectionsMaximum",
        .utilization_metrics_ebs_volume_read_iops_maximum = "UtilizationMetricsEBSVolumeReadIOPSMaximum",
        .utilization_metrics_ebs_volume_write_iops_maximum = "UtilizationMetricsEBSVolumeWriteIOPSMaximum",
        .utilization_metrics_volume_read_ops_per_second_maximum = "UtilizationMetricsVolumeReadOpsPerSecondMaximum",
        .utilization_metrics_volume_write_ops_per_second_maximum = "UtilizationMetricsVolumeWriteOpsPerSecondMaximum",
        .utilization_metrics_active_connection_count_maximum = "UtilizationMetricsActiveConnectionCountMaximum",
        .utilization_metrics_packets_in_from_source_maximum = "UtilizationMetricsPacketsInFromSourceMaximum",
        .utilization_metrics_packets_in_from_destination_maximum = "UtilizationMetricsPacketsInFromDestinationMaximum",
        .finding = "Finding",
        .finding_description = "FindingDescription",
        .tags = "Tags",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "AccountId",
            .resource_arn => "ResourceArn",
            .resource_id => "ResourceId",
            .resource_type => "ResourceType",
            .last_refresh_timestamp => "LastRefreshTimestamp",
            .lookback_period_in_days => "LookbackPeriodInDays",
            .savings_opportunity => "SavingsOpportunity",
            .savings_opportunity_after_discount => "SavingsOpportunityAfterDiscount",
            .utilization_metrics_cpu_maximum => "UtilizationMetricsCpuMaximum",
            .utilization_metrics_memory_maximum => "UtilizationMetricsMemoryMaximum",
            .utilization_metrics_network_out_bytes_per_second_maximum => "UtilizationMetricsNetworkOutBytesPerSecondMaximum",
            .utilization_metrics_network_in_bytes_per_second_maximum => "UtilizationMetricsNetworkInBytesPerSecondMaximum",
            .utilization_metrics_database_connections_maximum => "UtilizationMetricsDatabaseConnectionsMaximum",
            .utilization_metrics_ebs_volume_read_iops_maximum => "UtilizationMetricsEBSVolumeReadIOPSMaximum",
            .utilization_metrics_ebs_volume_write_iops_maximum => "UtilizationMetricsEBSVolumeWriteIOPSMaximum",
            .utilization_metrics_volume_read_ops_per_second_maximum => "UtilizationMetricsVolumeReadOpsPerSecondMaximum",
            .utilization_metrics_volume_write_ops_per_second_maximum => "UtilizationMetricsVolumeWriteOpsPerSecondMaximum",
            .utilization_metrics_active_connection_count_maximum => "UtilizationMetricsActiveConnectionCountMaximum",
            .utilization_metrics_packets_in_from_source_maximum => "UtilizationMetricsPacketsInFromSourceMaximum",
            .utilization_metrics_packets_in_from_destination_maximum => "UtilizationMetricsPacketsInFromDestinationMaximum",
            .finding => "Finding",
            .finding_description => "FindingDescription",
            .tags => "Tags",
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
