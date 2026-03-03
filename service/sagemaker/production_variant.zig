const ProductionVariantAcceleratorType = @import("production_variant_accelerator_type.zig").ProductionVariantAcceleratorType;
const ProductionVariantCapacityReservationConfig = @import("production_variant_capacity_reservation_config.zig").ProductionVariantCapacityReservationConfig;
const ProductionVariantCoreDumpConfig = @import("production_variant_core_dump_config.zig").ProductionVariantCoreDumpConfig;
const ProductionVariantInferenceAmiVersion = @import("production_variant_inference_ami_version.zig").ProductionVariantInferenceAmiVersion;
const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;
const ProductionVariantManagedInstanceScaling = @import("production_variant_managed_instance_scaling.zig").ProductionVariantManagedInstanceScaling;
const ProductionVariantRoutingConfig = @import("production_variant_routing_config.zig").ProductionVariantRoutingConfig;
const ProductionVariantServerlessConfig = @import("production_variant_serverless_config.zig").ProductionVariantServerlessConfig;

/// Identifies a model that you want to host and the resources chosen to deploy
/// for hosting it. If you are deploying multiple models, tell SageMaker how to
/// distribute traffic among the models by specifying variant weights. For more
/// information on production variants, check [ Production
/// variants](https://docs.aws.amazon.com/sagemaker/latest/dg/model-ab-testing.html).
pub const ProductionVariant = struct {
    /// This parameter is no longer supported. Elastic Inference (EI) is no longer
    /// available.
    ///
    /// This parameter was used to specify the size of the EI instance to use for
    /// the production variant.
    accelerator_type: ?ProductionVariantAcceleratorType = null,

    /// Settings for the capacity reservation for the compute instances that
    /// SageMaker AI reserves for an endpoint.
    capacity_reservation_config: ?ProductionVariantCapacityReservationConfig = null,

    /// The timeout value, in seconds, for your inference container to pass health
    /// check by SageMaker Hosting. For more information about health check, see
    /// [How Your Container Should Respond to Health Check (Ping)
    /// Requests](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-inference-code.html#your-algorithms-inference-algo-ping-requests).
    container_startup_health_check_timeout_in_seconds: ?i32 = null,

    /// Specifies configuration for a core dump from the model container when the
    /// process crashes.
    core_dump_config: ?ProductionVariantCoreDumpConfig = null,

    /// You can use this parameter to turn on native Amazon Web Services Systems
    /// Manager (SSM) access for a production variant behind an endpoint. By
    /// default, SSM access is disabled for all production variants behind an
    /// endpoint. You can turn on or turn off SSM access for a production variant
    /// behind an existing endpoint by creating a new endpoint configuration and
    /// calling `UpdateEndpoint`.
    enable_ssm_access: ?bool = null,

    /// Specifies an option from a collection of preconfigured Amazon Machine Image
    /// (AMI) images. Each image is configured by Amazon Web Services with a set of
    /// software and driver versions. Amazon Web Services optimizes these
    /// configurations for different machine learning workloads.
    ///
    /// By selecting an AMI version, you can ensure that your inference environment
    /// is compatible with specific software requirements, such as CUDA driver
    /// versions, Linux kernel versions, or Amazon Web Services Neuron driver
    /// versions.
    ///
    /// The AMI version names, and their configurations, are the following:
    ///
    /// **al2-ami-sagemaker-inference-gpu-2**
    ///
    /// * Accelerator: GPU
    /// * NVIDIA driver version: 535
    /// * CUDA version: 12.2
    ///
    /// **al2-ami-sagemaker-inference-gpu-2-1**
    ///
    /// * Accelerator: GPU
    /// * NVIDIA driver version: 535
    /// * CUDA version: 12.2
    /// * NVIDIA Container Toolkit with disabled CUDA-compat mounting
    ///
    /// **al2-ami-sagemaker-inference-gpu-3-1**
    ///
    /// * Accelerator: GPU
    /// * NVIDIA driver version: 550
    /// * CUDA version: 12.4
    /// * NVIDIA Container Toolkit with disabled CUDA-compat mounting
    ///
    /// **al2-ami-sagemaker-inference-neuron-2**
    ///
    /// * Accelerator: Inferentia2 and Trainium
    /// * Neuron driver version: 2.19
    inference_ami_version: ?ProductionVariantInferenceAmiVersion = null,

    /// Number of instances to launch initially.
    initial_instance_count: ?i32 = null,

    /// Determines initial traffic distribution among all of the models that you
    /// specify in the endpoint configuration. The traffic to a production variant
    /// is determined by the ratio of the `VariantWeight` to the sum of all
    /// `VariantWeight` values across all ProductionVariants. If unspecified, it
    /// defaults to 1.0.
    initial_variant_weight: ?f32 = null,

    /// The ML compute instance type.
    instance_type: ?ProductionVariantInstanceType = null,

    /// Settings that control the range in the number of instances that the endpoint
    /// provisions as it scales up or down to accommodate traffic.
    managed_instance_scaling: ?ProductionVariantManagedInstanceScaling = null,

    /// The timeout value, in seconds, to download and extract the model that you
    /// want to host from Amazon S3 to the individual inference instance associated
    /// with this production variant.
    model_data_download_timeout_in_seconds: ?i32 = null,

    /// The name of the model that you want to host. This is the name that you
    /// specified when creating the model.
    model_name: ?[]const u8 = null,

    /// Settings that control how the endpoint routes incoming traffic to the
    /// instances that the endpoint hosts.
    routing_config: ?ProductionVariantRoutingConfig = null,

    /// The serverless configuration for an endpoint. Specifies a serverless
    /// endpoint configuration instead of an instance-based endpoint configuration.
    serverless_config: ?ProductionVariantServerlessConfig = null,

    /// The name of the production variant.
    variant_name: []const u8,

    /// The size, in GB, of the ML storage volume attached to individual inference
    /// instance associated with the production variant. Currently only Amazon EBS
    /// gp2 storage volumes are supported.
    volume_size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .accelerator_type = "AcceleratorType",
        .capacity_reservation_config = "CapacityReservationConfig",
        .container_startup_health_check_timeout_in_seconds = "ContainerStartupHealthCheckTimeoutInSeconds",
        .core_dump_config = "CoreDumpConfig",
        .enable_ssm_access = "EnableSSMAccess",
        .inference_ami_version = "InferenceAmiVersion",
        .initial_instance_count = "InitialInstanceCount",
        .initial_variant_weight = "InitialVariantWeight",
        .instance_type = "InstanceType",
        .managed_instance_scaling = "ManagedInstanceScaling",
        .model_data_download_timeout_in_seconds = "ModelDataDownloadTimeoutInSeconds",
        .model_name = "ModelName",
        .routing_config = "RoutingConfig",
        .serverless_config = "ServerlessConfig",
        .variant_name = "VariantName",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
