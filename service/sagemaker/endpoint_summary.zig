const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;

/// Provides summary information for an endpoint.
pub const EndpointSummary = struct {
    /// A timestamp that shows when the endpoint was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The name of the endpoint.
    endpoint_name: []const u8,

    /// The status of the endpoint.
    ///
    /// * `OutOfService`: Endpoint is not available to take incoming requests.
    /// * `Creating`:
    ///   [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) is executing.
    /// * `Updating`:
    ///   [UpdateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpoint.html) or [UpdateEndpointWeightsAndCapacities](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpointWeightsAndCapacities.html) is executing.
    /// * `SystemUpdating`: Endpoint is undergoing maintenance and cannot be updated
    ///   or deleted or re-scaled until it has completed. This maintenance operation
    ///   does not change any customer-specified values such as VPC config, KMS
    ///   encryption, model, instance type, or instance count.
    /// * `RollingBack`: Endpoint fails to scale up or down or change its variant
    ///   weight and is in the process of rolling back to its previous
    ///   configuration. Once the rollback completes, endpoint returns to an
    ///   `InService` status. This transitional status only applies to an endpoint
    ///   that has autoscaling enabled and is undergoing variant weight or capacity
    ///   changes as part of an
    ///   [UpdateEndpointWeightsAndCapacities](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpointWeightsAndCapacities.html) call or when the [UpdateEndpointWeightsAndCapacities](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpointWeightsAndCapacities.html) operation is called explicitly.
    /// * `InService`: Endpoint is available to process incoming requests.
    /// * `Deleting`:
    ///   [DeleteEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteEndpoint.html) is executing.
    /// * `Failed`: Endpoint could not be created, updated, or re-scaled. Use
    ///   `DescribeEndpointOutput$FailureReason` for information about the failure.
    ///   [DeleteEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteEndpoint.html) is the only operation that can be performed on a failed endpoint.
    ///
    /// To get a list of endpoints with a specified status, use the `StatusEquals`
    /// filter with a call to
    /// [ListEndpoints](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListEndpoints.html).
    endpoint_status: EndpointStatus,

    /// A timestamp that shows when the endpoint was last modified.
    last_modified_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_arn = "EndpointArn",
        .endpoint_name = "EndpointName",
        .endpoint_status = "EndpointStatus",
        .last_modified_time = "LastModifiedTime",
    };
};
