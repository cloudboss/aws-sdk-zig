const AwsSageMakerNotebookInstanceMetadataServiceConfigurationDetails = @import("aws_sage_maker_notebook_instance_metadata_service_configuration_details.zig").AwsSageMakerNotebookInstanceMetadataServiceConfigurationDetails;

/// Provides details about an Amazon SageMaker AI notebook instance.
pub const AwsSageMakerNotebookInstanceDetails = struct {
    /// A list of Amazon Elastic Inference instance types to associate with the
    /// notebook instance. Currently, only one instance type can be associated with
    /// a notebook instance.
    accelerator_types: ?[]const []const u8,

    /// An array of up to three Git repositories associated with the notebook
    /// instance. These can be either the names of Git repositories stored as
    /// resources in your account, or the URL of Git repositories in
    /// [CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository.
    /// These repositories are cloned at the same level as the default repository of
    /// your notebook instance. For more information, see [Associating Git
    /// repositories with SageMaker AI notebook
    /// instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html) in the *Amazon SageMaker AI Developer Guide*.
    additional_code_repositories: ?[]const []const u8,

    /// The Git repository associated with the notebook instance as its default code
    /// repository. This can be either the name of a Git repository stored as a
    /// resource in your account, or the URL of a Git repository in
    /// [CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository.
    /// When you open a notebook instance, it opens in the directory that contains
    /// this repository. For more information, see [Associating Git repositories
    /// with SageMaker AI notebook
    /// instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html) in the *Amazon SageMaker AI Developer Guide*.
    default_code_repository: ?[]const u8,

    /// Sets whether SageMaker AI provides internet access to the notebook instance.
    /// If you set this to `Disabled`, this notebook instance is able to access
    /// resources only in your VPC, and is not be able to connect to SageMaker AI
    /// training and endpoint services unless you configure a Network Address
    /// Translation (NAT) Gateway in your VPC.
    direct_internet_access: ?[]const u8,

    /// If status of the instance is `Failed`, the reason it failed.
    failure_reason: ?[]const u8,

    /// Information on the IMDS configuration of the notebook instance.
    instance_metadata_service_configuration: ?AwsSageMakerNotebookInstanceMetadataServiceConfigurationDetails,

    /// The type of machine learning (ML) compute instance to launch for the
    /// notebook instance.
    instance_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of an Key Management Service (KMS) key that
    /// SageMaker AI uses to encrypt data on the storage volume attached to your
    /// notebook instance. The KMS key you provide must be enabled. For information,
    /// see
    /// [Enabling and disabling
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/enabling-keys.html) in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8,

    /// The network interface ID that SageMaker AI created when the instance was
    /// created.
    network_interface_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the notebook instance.
    notebook_instance_arn: ?[]const u8,

    /// The name of a notebook instance lifecycle configuration.
    notebook_instance_lifecycle_config_name: ?[]const u8,

    /// The name of the new notebook instance.
    notebook_instance_name: ?[]const u8,

    /// The status of the notebook instance.
    notebook_instance_status: ?[]const u8,

    /// The platform identifier of the notebook instance runtime environment.
    platform_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the instance.
    role_arn: ?[]const u8,

    /// Whether root access is enabled or disabled for users of the notebook
    /// instance.
    root_access: ?[]const u8,

    /// The VPC security group IDs.
    security_groups: ?[]const []const u8,

    /// The ID of the VPC subnet to which you have a connectivity from your ML
    /// compute instance.
    subnet_id: ?[]const u8,

    /// The URL that you use to connect to the Jupyter notebook that is running in
    /// your notebook instance.
    url: ?[]const u8,

    /// The size, in GB, of the ML storage volume to attach to the notebook
    /// instance.
    volume_size_in_gb: ?i32,

    pub const json_field_names = .{
        .accelerator_types = "AcceleratorTypes",
        .additional_code_repositories = "AdditionalCodeRepositories",
        .default_code_repository = "DefaultCodeRepository",
        .direct_internet_access = "DirectInternetAccess",
        .failure_reason = "FailureReason",
        .instance_metadata_service_configuration = "InstanceMetadataServiceConfiguration",
        .instance_type = "InstanceType",
        .kms_key_id = "KmsKeyId",
        .network_interface_id = "NetworkInterfaceId",
        .notebook_instance_arn = "NotebookInstanceArn",
        .notebook_instance_lifecycle_config_name = "NotebookInstanceLifecycleConfigName",
        .notebook_instance_name = "NotebookInstanceName",
        .notebook_instance_status = "NotebookInstanceStatus",
        .platform_identifier = "PlatformIdentifier",
        .role_arn = "RoleArn",
        .root_access = "RootAccess",
        .security_groups = "SecurityGroups",
        .subnet_id = "SubnetId",
        .url = "Url",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
