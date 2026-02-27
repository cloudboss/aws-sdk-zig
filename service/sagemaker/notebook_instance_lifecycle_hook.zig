/// Contains the notebook instance lifecycle configuration script.
///
/// Each lifecycle configuration script has a limit of 16384 characters.
///
/// The value of the `$PATH` environment variable that is available to both
/// scripts is `/sbin:bin:/usr/sbin:/usr/bin`.
///
/// View Amazon CloudWatch Logs for notebook instance lifecycle configurations
/// in log group `/aws/sagemaker/NotebookInstances` in log stream
/// `[notebook-instance-name]/[LifecycleConfigHook]`.
///
/// Lifecycle configuration scripts cannot run for longer than 5 minutes. If a
/// script runs for longer than 5 minutes, it fails and the notebook instance is
/// not created or started.
///
/// For information about notebook instance lifestyle configurations, see [Step
/// 2.1: (Optional) Customize a Notebook
/// Instance](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html).
pub const NotebookInstanceLifecycleHook = struct {
    /// A base64-encoded string that contains a shell script for a notebook instance
    /// lifecycle configuration.
    content: ?[]const u8,

    pub const json_field_names = .{
        .content = "Content",
    };
};
