const ElasticsearchClusterConfig = @import("elasticsearch_cluster_config.zig").ElasticsearchClusterConfig;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Specifies the configuration status for the specified Elasticsearch domain.
pub const ElasticsearchClusterConfigStatus = struct {
    /// Specifies the cluster configuration for the specified Elasticsearch domain.
    options: ElasticsearchClusterConfig,

    /// Specifies the status of the configuration for the specified Elasticsearch
    /// domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
