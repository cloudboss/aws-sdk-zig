const InstanceType = @import("instance_type.zig").InstanceType;
const NotebookInstanceStatus = @import("notebook_instance_status.zig").NotebookInstanceStatus;

/// Provides summary information for an SageMaker AI notebook instance.
pub const NotebookInstanceSummary = struct {
    /// An array of up to three Git repositories associated with the notebook
    /// instance. These can be either the names of Git repositories stored as
    /// resources in your account, or the URL of Git repositories in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. These repositories are cloned at the same level as the default repository of your notebook instance. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    additional_code_repositories: ?[]const []const u8 = null,

    /// A timestamp that shows when the notebook instance was created.
    creation_time: ?i64 = null,

    /// The Git repository associated with the notebook instance as its default code
    /// repository. This can be either the name of a Git repository stored as a
    /// resource in your account, or the URL of a Git repository in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. When you open a notebook instance, it opens in the directory that contains this repository. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    default_code_repository: ?[]const u8 = null,

    /// The type of ML compute instance that the notebook instance is running on.
    instance_type: ?InstanceType = null,

    /// A timestamp that shows when the notebook instance was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the notebook instance.
    notebook_instance_arn: []const u8,

    /// The name of a notebook instance lifecycle configuration associated with this
    /// notebook instance.
    ///
    /// For information about notebook instance lifestyle configurations, see [Step
    /// 2.1: (Optional) Customize a Notebook
    /// Instance](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html).
    notebook_instance_lifecycle_config_name: ?[]const u8 = null,

    /// The name of the notebook instance that you want a summary for.
    notebook_instance_name: []const u8,

    /// The status of the notebook instance.
    notebook_instance_status: ?NotebookInstanceStatus = null,

    /// The URL that you use to connect to the Jupyter notebook running in your
    /// notebook instance.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_code_repositories = "AdditionalCodeRepositories",
        .creation_time = "CreationTime",
        .default_code_repository = "DefaultCodeRepository",
        .instance_type = "InstanceType",
        .last_modified_time = "LastModifiedTime",
        .notebook_instance_arn = "NotebookInstanceArn",
        .notebook_instance_lifecycle_config_name = "NotebookInstanceLifecycleConfigName",
        .notebook_instance_name = "NotebookInstanceName",
        .notebook_instance_status = "NotebookInstanceStatus",
        .url = "Url",
    };
};
