const ServiceStatus = @import("service_status.zig").ServiceStatus;

/// Provides summary information for an App Runner service.
///
/// This type contains limited information about a service. It doesn't include
/// configuration details. It's returned by the
/// [ListServices](https://docs.aws.amazon.com/apprunner/latest/api/API_ListServices.html) action. Complete service information is returned by the [CreateService](https://docs.aws.amazon.com/apprunner/latest/api/API_CreateService.html), [DescribeService](https://docs.aws.amazon.com/apprunner/latest/api/API_DescribeService.html), and [DeleteService](https://docs.aws.amazon.com/apprunner/latest/api/API_DeleteService.html) actions using the [Service](https://docs.aws.amazon.com/apprunner/latest/api/API_Service.html) type.
pub const ServiceSummary = struct {
    /// The time when the App Runner service was created. It's in the Unix time
    /// stamp format.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of this service.
    service_arn: ?[]const u8 = null,

    /// An ID that App Runner generated for this service. It's unique within the
    /// Amazon Web Services Region.
    service_id: ?[]const u8 = null,

    /// The customer-provided service name.
    service_name: ?[]const u8 = null,

    /// A subdomain URL that App Runner generated for this service. You can use this
    /// URL to access your service web application.
    service_url: ?[]const u8 = null,

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
    status: ?ServiceStatus = null,

    /// The time when the App Runner service was last updated. It's in theUnix time
    /// stamp format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .service_arn = "ServiceArn",
        .service_id = "ServiceId",
        .service_name = "ServiceName",
        .service_url = "ServiceUrl",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
