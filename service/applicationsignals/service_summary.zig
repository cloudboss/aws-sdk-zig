const aws = @import("aws");

const MetricReference = @import("metric_reference.zig").MetricReference;
const ServiceGroup = @import("service_group.zig").ServiceGroup;

/// This structure contains information about one of your services that was
/// discovered by Application Signals
pub const ServiceSummary = struct {
    /// This structure contains one or more string-to-string maps that help identify
    /// this service. It can include *platform attributes*, *application
    /// attributes*, and *telemetry attributes*.
    ///
    /// Platform attributes contain information the service's platform.
    ///
    /// * `PlatformType` defines the hosted-in platform.
    /// * `EKS.Cluster` is the name of the Amazon EKS cluster.
    /// * `K8s.Cluster` is the name of the self-hosted Kubernetes cluster.
    /// * `K8s.Namespace` is the name of the Kubernetes namespace in either Amazon
    ///   EKS or Kubernetes clusters.
    /// * `K8s.Workload` is the name of the Kubernetes workload in either Amazon EKS
    ///   or Kubernetes clusters.
    /// * `K8s.Node` is the name of the Kubernetes node in either Amazon EKS or
    ///   Kubernetes clusters.
    /// * `K8s.Pod` is the name of the Kubernetes pod in either Amazon EKS or
    ///   Kubernetes clusters.
    /// * `EC2.AutoScalingGroup` is the name of the Amazon EC2 Auto Scaling group.
    /// * `EC2.InstanceId` is the ID of the Amazon EC2 instance.
    /// * `Host` is the name of the host, for all platform types.
    ///
    /// Application attributes contain information about the application.
    ///
    /// * `AWS.Application` is the application's name in Amazon Web Services Service
    ///   Catalog AppRegistry.
    /// * `AWS.Application.ARN` is the application's ARN in Amazon Web Services
    ///   Service Catalog AppRegistry.
    ///
    /// Telemetry attributes contain telemetry information.
    ///
    /// * `Telemetry.SDK` is the fingerprint of the OpenTelemetry SDK version for
    ///   instrumented services.
    /// * `Telemetry.Agent` is the fingerprint of the agent used to collect and send
    ///   telemetry data.
    /// * `Telemetry.Source` Specifies the point of application where the telemetry
    ///   was collected or specifies what was used for the source of telemetry data.
    attribute_maps: ?[]const []const aws.map.StringMapEntry,

    /// This is a string-to-string map that help identify the objects discovered by
    /// Application Signals. It can include the following fields.
    ///
    /// * `Type` designates the type of object this is.
    /// * `ResourceType` specifies the type of the resource. This field is used only
    ///   when the value of the `Type` field is `Resource` or `AWS::Resource`.
    /// * `Name` specifies the name of the object. This is used only if the value of
    ///   the `Type` field is `Service`, `RemoteService`, or `AWS::Service`.
    /// * `Identifier` identifies the resource objects of this resource. This is
    ///   used only if the value of the `Type` field is `Resource` or
    ///   `AWS::Resource`.
    /// * `Environment` specifies the location where this object is hosted, or what
    ///   it belongs to.
    key_attributes: []const aws.map.StringMapEntry,

    /// An array of structures that each contain information about one metric
    /// associated with this service.
    metric_references: []const MetricReference,

    /// An array of service groups that this service belongs to, based on the
    /// configured grouping attributes.
    service_groups: ?[]const ServiceGroup,

    pub const json_field_names = .{
        .attribute_maps = "AttributeMaps",
        .key_attributes = "KeyAttributes",
        .metric_references = "MetricReferences",
        .service_groups = "ServiceGroups",
    };
};
