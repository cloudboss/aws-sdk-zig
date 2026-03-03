const AutoScalingConfigurationSummary = @import("auto_scaling_configuration_summary.zig").AutoScalingConfigurationSummary;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const HealthCheckConfiguration = @import("health_check_configuration.zig").HealthCheckConfiguration;
const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ServiceObservabilityConfiguration = @import("service_observability_configuration.zig").ServiceObservabilityConfiguration;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const ServiceStatus = @import("service_status.zig").ServiceStatus;

/// Describes an App Runner service. It can describe a service in any state,
/// including deleted services.
///
/// This type contains the full information about a service, including
/// configuration details. It's returned by the
/// [CreateService](https://docs.aws.amazon.com/apprunner/latest/api/API_CreateService.html), [DescribeService](https://docs.aws.amazon.com/apprunner/latest/api/API_DescribeService.html), and [DeleteService](https://docs.aws.amazon.com/apprunner/latest/api/API_DeleteService.html) actions. A subset of this
/// information is returned by the
/// [ListServices](https://docs.aws.amazon.com/apprunner/latest/api/API_ListServices.html) action using the [ServiceSummary](https://docs.aws.amazon.com/apprunner/latest/api/API_ServiceSummary.html) type.
pub const Service = struct {
    /// Summary information for the App Runner automatic scaling configuration
    /// resource that's associated with this service.
    auto_scaling_configuration_summary: AutoScalingConfigurationSummary,

    /// The time when the App Runner service was created. It's in the Unix time
    /// stamp format.
    created_at: i64,

    /// The time when the App Runner service was deleted. It's in the Unix time
    /// stamp format.
    deleted_at: ?i64 = null,

    /// The encryption key that App Runner uses to encrypt the service logs and the
    /// copy of the source repository that App Runner maintains for the service. It
    /// can be
    /// either a customer-provided encryption key or an Amazon Web Services managed
    /// key.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The settings for the health check that App Runner performs to monitor the
    /// health of this service.
    health_check_configuration: ?HealthCheckConfiguration = null,

    /// The runtime configuration of instances (scaling units) of this service.
    instance_configuration: InstanceConfiguration,

    /// Configuration settings related to network traffic of the web application
    /// that this service runs.
    network_configuration: NetworkConfiguration,

    /// The observability configuration of this service.
    observability_configuration: ?ServiceObservabilityConfiguration = null,

    /// The Amazon Resource Name (ARN) of this service.
    service_arn: []const u8,

    /// An ID that App Runner generated for this service. It's unique within the
    /// Amazon Web Services Region.
    service_id: []const u8,

    /// The customer-provided service name.
    service_name: []const u8,

    /// A subdomain URL that App Runner generated for this service. You can use this
    /// URL to access your service web application.
    service_url: ?[]const u8 = null,

    /// The source deployed to the App Runner service. It can be a code or an image
    /// repository.
    source_configuration: SourceConfiguration,

    /// The current state of the App Runner service. These particular values mean
    /// the following.
    ///
    /// * `CREATE_FAILED` – The service failed to create. The failed service isn't
    ///   usable, and still counts towards your service quota. To
    /// troubleshoot this failure, read the failure events and logs, change any
    /// parameters that need to be fixed, and rebuild your service using
    /// `UpdateService`.
    ///
    /// * `DELETE_FAILED` – The service failed to delete and can't be successfully
    ///   recovered. Retry the service deletion call to ensure
    /// that all related resources are removed.
    status: ServiceStatus,

    /// The time when the App Runner service was last updated at. It's in the Unix
    /// time stamp format.
    updated_at: i64,

    pub const json_field_names = .{
        .auto_scaling_configuration_summary = "AutoScalingConfigurationSummary",
        .created_at = "CreatedAt",
        .deleted_at = "DeletedAt",
        .encryption_configuration = "EncryptionConfiguration",
        .health_check_configuration = "HealthCheckConfiguration",
        .instance_configuration = "InstanceConfiguration",
        .network_configuration = "NetworkConfiguration",
        .observability_configuration = "ObservabilityConfiguration",
        .service_arn = "ServiceArn",
        .service_id = "ServiceId",
        .service_name = "ServiceName",
        .service_url = "ServiceUrl",
        .source_configuration = "SourceConfiguration",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
