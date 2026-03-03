const BootstrapActionDetail = @import("bootstrap_action_detail.zig").BootstrapActionDetail;
const JobFlowExecutionStatusDetail = @import("job_flow_execution_status_detail.zig").JobFlowExecutionStatusDetail;
const JobFlowInstancesDetail = @import("job_flow_instances_detail.zig").JobFlowInstancesDetail;
const ScaleDownBehavior = @import("scale_down_behavior.zig").ScaleDownBehavior;
const StepDetail = @import("step_detail.zig").StepDetail;

/// A description of a cluster (job flow).
pub const JobFlowDetail = struct {
    /// Applies only to Amazon EMR AMI versions 3.x and 2.x. For Amazon EMR
    /// releases 4.0 and later, `ReleaseLabel` is used. To specify a custom AMI, use
    /// `CustomAmiID`.
    ami_version: ?[]const u8 = null,

    /// An IAM role for automatic scaling policies. The default role is
    /// `EMR_AutoScaling_DefaultRole`. The IAM role provides a way for
    /// the automatic scaling feature to get the required permissions it needs to
    /// launch and
    /// terminate Amazon EC2 instances in an instance group.
    auto_scaling_role: ?[]const u8 = null,

    /// A list of the bootstrap actions run by the job flow.
    bootstrap_actions: ?[]const BootstrapActionDetail = null,

    /// Describes the execution status of the job flow.
    execution_status_detail: JobFlowExecutionStatusDetail,

    /// Describes the Amazon EC2 instances of the job flow.
    instances: JobFlowInstancesDetail,

    /// The job flow identifier.
    job_flow_id: []const u8,

    /// The IAM role that was specified when the job flow was launched. The
    /// Amazon EC2 instances of the job flow assume this role.
    job_flow_role: ?[]const u8 = null,

    /// The KMS key used for encrypting log files. This attribute is only
    /// available with Amazon EMR 5.30.0 and later, excluding 6.0.0.
    log_encryption_kms_key_id: ?[]const u8 = null,

    /// The location in Amazon S3 where log files for the job are stored.
    log_uri: ?[]const u8 = null,

    /// The name of the job flow.
    name: []const u8,

    /// The way that individual Amazon EC2 instances terminate when an automatic
    /// scale-in activity occurs or an instance group is resized.
    /// `TERMINATE_AT_INSTANCE_HOUR` indicates that Amazon EMR terminates
    /// nodes at the instance-hour boundary, regardless of when the request to
    /// terminate the
    /// instance was submitted. This option is only available with Amazon EMR 5.1.0
    /// and
    /// later and is the default for clusters created using that version.
    /// `TERMINATE_AT_TASK_COMPLETION` indicates that Amazon EMR adds nodes
    /// to a deny list and drains tasks from nodes before terminating the Amazon EC2
    /// instances, regardless of the instance-hour boundary. With either behavior,
    /// Amazon EMR removes the least active nodes first and blocks instance
    /// termination if it could lead to
    /// HDFS corruption. `TERMINATE_AT_TASK_COMPLETION` available only in Amazon EMR
    /// releases 4.1.0 and later, and is the default for releases of Amazon EMR
    /// earlier than 5.1.0.
    scale_down_behavior: ?ScaleDownBehavior = null,

    /// The IAM role that is assumed by the Amazon EMR service to access
    /// Amazon Web Services resources on your behalf.
    service_role: ?[]const u8 = null,

    /// A list of steps run by the job flow.
    steps: ?[]const StepDetail = null,

    /// A list of strings set by third-party software when the job flow is launched.
    /// If you are
    /// not using third-party software to manage the job flow, this value is empty.
    supported_products: ?[]const []const u8 = null,

    /// Indicates whether the cluster is visible to IAM principals in the Amazon Web
    /// Services account associated with the cluster. When `true`, IAM principals in
    /// the Amazon Web Services account can perform Amazon EMR cluster
    /// actions that their IAM policies allow. When `false`, only the
    /// IAM principal that created the cluster and the Amazon Web Services account
    /// root user can perform Amazon EMR actions, regardless of IAM
    /// permissions policies attached to other IAM principals.
    ///
    /// The default value is `true` if a value is not provided when creating a
    /// cluster using the Amazon EMR API RunJobFlow command, the CLI
    /// [create-cluster](https://docs.aws.amazon.com/cli/latest/reference/emr/create-cluster.html) command, or the Amazon Web Services Management Console.
    visible_to_all_users: ?bool = null,

    pub const json_field_names = .{
        .ami_version = "AmiVersion",
        .auto_scaling_role = "AutoScalingRole",
        .bootstrap_actions = "BootstrapActions",
        .execution_status_detail = "ExecutionStatusDetail",
        .instances = "Instances",
        .job_flow_id = "JobFlowId",
        .job_flow_role = "JobFlowRole",
        .log_encryption_kms_key_id = "LogEncryptionKmsKeyId",
        .log_uri = "LogUri",
        .name = "Name",
        .scale_down_behavior = "ScaleDownBehavior",
        .service_role = "ServiceRole",
        .steps = "Steps",
        .supported_products = "SupportedProducts",
        .visible_to_all_users = "VisibleToAllUsers",
    };
};
