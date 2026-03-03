/// Settings that take effect while the model container starts up.
pub const InferenceComponentStartupParameters = struct {
    /// The timeout value, in seconds, for your inference container to pass health
    /// check by Amazon S3 Hosting. For more information about health check, see
    /// [How Your Container Should Respond to Health Check (Ping)
    /// Requests](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms-inference-code.html#your-algorithms-inference-algo-ping-requests).
    container_startup_health_check_timeout_in_seconds: ?i32 = null,

    /// The timeout value, in seconds, to download and extract the model that you
    /// want to host from Amazon S3 to the individual inference instance associated
    /// with this inference component.
    model_data_download_timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .container_startup_health_check_timeout_in_seconds = "ContainerStartupHealthCheckTimeoutInSeconds",
        .model_data_download_timeout_in_seconds = "ModelDataDownloadTimeoutInSeconds",
    };
};
