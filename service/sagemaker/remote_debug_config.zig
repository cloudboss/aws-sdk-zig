/// Configuration for remote debugging for the
/// [CreateTrainingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingJob.html) API. To learn more about the remote debugging functionality of SageMaker, see [Access a training container through Amazon Web Services Systems Manager (SSM) for remote debugging](https://docs.aws.amazon.com/sagemaker/latest/dg/train-remote-debugging.html).
pub const RemoteDebugConfig = struct {
    /// If set to True, enables remote debugging.
    enable_remote_debug: ?bool,

    pub const json_field_names = .{
        .enable_remote_debug = "EnableRemoteDebug",
    };
};
