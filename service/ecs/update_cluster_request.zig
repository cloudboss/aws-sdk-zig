const ClusterConfiguration = @import("cluster_configuration.zig").ClusterConfiguration;
const ClusterServiceConnectDefaultsRequest = @import("cluster_service_connect_defaults_request.zig").ClusterServiceConnectDefaultsRequest;
const ClusterSetting = @import("cluster_setting.zig").ClusterSetting;

pub const UpdateClusterRequest = struct {
    /// The name of the cluster to modify the settings for.
    cluster: []const u8,

    /// The execute command configuration for the cluster.
    configuration: ?ClusterConfiguration = null,

    /// Use this parameter to set a default Service Connect namespace. After you set
    /// a default
    /// Service Connect namespace, any new services with Service Connect turned on
    /// that are
    /// created in the cluster are added as client services in the namespace. This
    /// setting only
    /// applies to new services that set the `enabled` parameter to `true`
    /// in the `ServiceConnectConfiguration`. You can set the namespace of each
    /// service individually in the `ServiceConnectConfiguration` to override this
    /// default parameter.
    ///
    /// Tasks that run in a namespace can use short names to connect to services in
    /// the
    /// namespace. Tasks can connect to services across all of the clusters in the
    /// namespace.
    /// Tasks connect through a managed proxy container that collects logs and
    /// metrics for
    /// increased visibility. Only the tasks that Amazon ECS services create are
    /// supported with
    /// Service Connect. For more information, see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    service_connect_defaults: ?ClusterServiceConnectDefaultsRequest = null,

    /// The cluster settings for your cluster.
    settings: ?[]const ClusterSetting = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .configuration = "configuration",
        .service_connect_defaults = "serviceConnectDefaults",
        .settings = "settings",
    };
};
