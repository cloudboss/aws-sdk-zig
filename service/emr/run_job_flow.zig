const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Application = @import("application.zig").Application;
const AutoTerminationPolicy = @import("auto_termination_policy.zig").AutoTerminationPolicy;
const BootstrapActionConfig = @import("bootstrap_action_config.zig").BootstrapActionConfig;
const Configuration = @import("configuration.zig").Configuration;
const JobFlowInstancesConfig = @import("job_flow_instances_config.zig").JobFlowInstancesConfig;
const KerberosAttributes = @import("kerberos_attributes.zig").KerberosAttributes;
const ManagedScalingPolicy = @import("managed_scaling_policy.zig").ManagedScalingPolicy;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const SupportedProductConfig = @import("supported_product_config.zig").SupportedProductConfig;
const PlacementGroupConfig = @import("placement_group_config.zig").PlacementGroupConfig;
const RepoUpgradeOnBoot = @import("repo_upgrade_on_boot.zig").RepoUpgradeOnBoot;
const ScaleDownBehavior = @import("scale_down_behavior.zig").ScaleDownBehavior;
const StepConfig = @import("step_config.zig").StepConfig;
const Tag = @import("tag.zig").Tag;

pub const RunJobFlowInput = struct {
    /// A JSON string for selecting additional features.
    additional_info: ?[]const u8 = null,

    /// Applies only to Amazon EMR AMI versions 3.x and 2.x. For Amazon EMR
    /// releases 4.0 and later, `ReleaseLabel` is used. To specify a custom AMI, use
    /// `CustomAmiID`.
    ami_version: ?[]const u8 = null,

    /// Applies to Amazon EMR releases 4.0 and later. A case-insensitive list of
    /// applications for Amazon EMR to install and configure when launching the
    /// cluster.
    /// For a list of applications available for each Amazon EMR release version,
    /// see the
    /// [Amazon EMRRelease
    /// Guide](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/).
    applications: ?[]const Application = null,

    /// An IAM role for automatic scaling policies. The default role is
    /// `EMR_AutoScaling_DefaultRole`. The IAM role provides
    /// permissions that the automatic scaling feature requires to launch and
    /// terminate Amazon EC2 instances in an instance group.
    auto_scaling_role: ?[]const u8 = null,

    auto_termination_policy: ?AutoTerminationPolicy = null,

    /// A list of bootstrap actions to run before Hadoop starts on the cluster
    /// nodes.
    bootstrap_actions: ?[]const BootstrapActionConfig = null,

    /// For Amazon EMR releases 4.0 and later. The list of configurations supplied
    /// for
    /// the Amazon EMR cluster that you are creating.
    configurations: ?[]const Configuration = null,

    /// Available only in Amazon EMR releases 5.7.0 and later. The ID of a custom
    /// Amazon
    /// EBS-backed Linux AMI. If specified, Amazon EMR uses this AMI when it
    /// launches
    /// cluster Amazon EC2 instances. For more information about custom AMIs in
    /// Amazon EMR, see [Using a Custom
    /// AMI](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-custom-ami.html) in the
    /// *Amazon EMR Management Guide*. If omitted, the cluster
    /// uses the base Linux AMI for the `ReleaseLabel` specified. For Amazon EMR
    /// releases 2.x and 3.x, use `AmiVersion` instead.
    ///
    /// For information about creating a custom AMI, see [Creating an Amazon
    /// EBS-Backed Linux
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html) in the *Amazon Elastic Compute Cloud User Guide for Linux
    /// Instances*. For information about finding an AMI ID, see [Finding a Linux
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html).
    custom_ami_id: ?[]const u8 = null,

    /// The IOPS, of the Amazon EBS root device volume of the Linux AMI that is
    /// used for each Amazon EC2 instance. Available in Amazon EMR releases 6.15.0
    /// and
    /// later.
    ebs_root_volume_iops: ?i32 = null,

    /// The size, in GiB, of the Amazon EBS root device volume of the Linux AMI that
    /// is
    /// used for each Amazon EC2 instance. Available in Amazon EMR releases 4.x and
    /// later.
    ebs_root_volume_size: ?i32 = null,

    /// The throughput, in MiB/s, of the Amazon EBS root device volume of the Linux
    /// AMI that is
    /// used for each Amazon EC2 instance. Available in Amazon EMR releases 6.15.0
    /// and
    /// later.
    ebs_root_volume_throughput: ?i32 = null,

    /// Reserved.
    extended_support: ?bool = null,

    /// A specification of the number and type of Amazon EC2 instances.
    instances: JobFlowInstancesConfig,

    /// Also called instance profile and Amazon EC2 role. An IAM role for
    /// an Amazon EMR cluster. The Amazon EC2 instances of the cluster assume this
    /// role. The default role is `EMR_EC2_DefaultRole`. In order to use the default
    /// role, you must have already created it using the CLI or console.
    job_flow_role: ?[]const u8 = null,

    /// Attributes for Kerberos configuration when Kerberos authentication is
    /// enabled using a
    /// security configuration. For more information see [Use Kerberos
    /// Authentication](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-kerberos.html)
    /// in the *Amazon EMR Management Guide*.
    kerberos_attributes: ?KerberosAttributes = null,

    /// The KMS key used for encrypting log files. If a value is not
    /// provided, the logs remain encrypted by AES-256. This attribute is only
    /// available with
    /// Amazon EMR releases 5.30.0 and later, excluding Amazon EMR 6.0.0.
    log_encryption_kms_key_id: ?[]const u8 = null,

    /// The location in Amazon S3 to write the log files of the job flow. If a value
    /// is
    /// not provided, logs are not created.
    log_uri: ?[]const u8 = null,

    /// The specified managed scaling policy for an Amazon EMR cluster.
    managed_scaling_policy: ?ManagedScalingPolicy = null,

    /// Contains CloudWatch log configuration metadata and settings.
    monitoring_configuration: ?MonitoringConfiguration = null,

    /// The name of the job flow.
    name: []const u8,

    /// For Amazon EMR releases 3.x and 2.x. For Amazon EMR releases 4.x and
    /// later, use Applications.
    ///
    /// A list of strings that indicates third-party software to use with the job
    /// flow that
    /// accepts a user argument list. Amazon EMR accepts and forwards the argument
    /// list to
    /// the corresponding installation script as bootstrap action arguments. For
    /// more information,
    /// see "Launch a Job Flow on the MapR Distribution for Hadoop" in the [Amazon
    /// EMR
    /// Developer
    /// Guide](https://docs.aws.amazon.com/emr/latest/DeveloperGuide/emr-dg.pdf).
    /// Supported values are:
    ///
    /// * "mapr-m3" - launch the cluster using MapR M3 Edition.
    ///
    /// * "mapr-m5" - launch the cluster using MapR M5 Edition.
    ///
    /// * "mapr" with the user arguments specifying "--edition,m3" or "--edition,m5"
    ///   -
    /// launch the job flow using MapR M3 or M5 Edition respectively.
    ///
    /// * "mapr-m7" - launch the cluster using MapR M7 Edition.
    ///
    /// * "hunk" - launch the cluster with the Hunk Big Data Analytics Platform.
    ///
    /// * "hue"- launch the cluster with Hue installed.
    ///
    /// * "spark" - launch the cluster with Apache Spark installed.
    ///
    /// * "ganglia" - launch the cluster with the Ganglia Monitoring System
    /// installed.
    new_supported_products: ?[]const SupportedProductConfig = null,

    /// Specifies a particular Amazon Linux release for all nodes in a cluster
    /// launch RunJobFlow
    /// request. If a release is not specified, Amazon EMR uses the latest validated
    /// Amazon
    /// Linux release for cluster launch.
    os_release_label: ?[]const u8 = null,

    /// The specified placement group configuration for an Amazon EMR cluster.
    placement_group_configs: ?[]const PlacementGroupConfig = null,

    /// The Amazon EMR release label, which determines the version of open-source
    /// application packages installed on the cluster. Release labels are in the
    /// form
    /// `emr-x.x.x`, where x.x.x is an Amazon EMR release version such as
    /// `emr-5.14.0`. For more information about Amazon EMR release versions
    /// and included application versions and features, see
    /// [https://docs.aws.amazon.com/emr/latest/ReleaseGuide/](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/). The release label applies only to Amazon EMR
    /// releases version 4.0 and later. Earlier versions use `AmiVersion`.
    release_label: ?[]const u8 = null,

    /// Applies only when `CustomAmiID` is used. Specifies which updates from the
    /// Amazon Linux AMI package repositories to apply automatically when the
    /// instance boots using
    /// the AMI. If omitted, the default is `SECURITY`, which indicates that only
    /// security updates are applied. If `NONE` is specified, no updates are
    /// applied,
    /// and all updates must be applied manually.
    repo_upgrade_on_boot: ?RepoUpgradeOnBoot = null,

    /// Specifies the way that individual Amazon EC2 instances terminate when an
    /// automatic scale-in activity occurs or an instance group is resized.
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

    /// The name of a security configuration to apply to the cluster.
    security_configuration: ?[]const u8 = null,

    /// The IAM role that Amazon EMR assumes in order to access Amazon Web Services
    /// resources on your behalf. If you've created a custom service role path, you
    /// must specify it for the service role when you launch your cluster.
    service_role: ?[]const u8 = null,

    /// Specifies the number of steps that can be executed concurrently. The default
    /// value is
    /// `1`. The maximum value is `256`.
    step_concurrency_level: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the runtime role for steps specified in
    /// the
    /// RunJobFlow request. The runtime role can be a cross-account IAM role.
    /// The runtime role ARN is a combination of account ID, role name, and role
    /// type using the
    /// following format: `arn:partition:iam::account-id:role/role-name`.
    ///
    /// For example, `arn:aws:iam::1234567890:role/ReadOnly` is a correctly
    /// formatted
    /// runtime role ARN.
    ///
    /// This parameter applies only to steps included in the `Steps` parameter of
    /// this
    /// RunJobFlow request. It does not apply to steps added later to the cluster.
    step_execution_role_arn: ?[]const u8 = null,

    /// A list of steps to run.
    steps: ?[]const StepConfig = null,

    /// For Amazon EMR releases 3.x and 2.x. For Amazon EMR releases 4.x and
    /// later, use Applications.
    ///
    /// A list of strings that indicates third-party software to use. For more
    /// information, see
    /// the [Amazon EMR Developer
    /// Guide](https://docs.aws.amazon.com/emr/latest/DeveloperGuide/emr-dg.pdf).
    /// Currently supported values are:
    ///
    /// * "mapr-m3" - launch the job flow using MapR M3 Edition.
    ///
    /// * "mapr-m5" - launch the job flow using MapR M5 Edition.
    supported_products: ?[]const []const u8 = null,

    /// A list of tags to associate with a cluster and propagate to Amazon EC2
    /// instances.
    tags: ?[]const Tag = null,

    /// The VisibleToAllUsers parameter is no longer supported. By default, the
    /// value is set
    /// to `true`. Setting it to `false` now has no effect.
    ///
    /// Set this value to `true` so that IAM principals in the Amazon Web Services
    /// account associated with the cluster can perform Amazon EMR actions on
    /// the cluster that their IAM policies allow. This value defaults to
    /// `true` for clusters created using the Amazon EMR API or the CLI
    /// [create-cluster](https://docs.aws.amazon.com/cli/latest/reference/emr/create-cluster.html) command.
    ///
    /// When set to `false`, only the IAM principal that created the
    /// cluster and the Amazon Web Services account root user can perform Amazon EMR
    /// actions
    /// for the cluster, regardless of the IAM permissions policies attached to
    /// other IAM principals. For more information, see [Understanding the Amazon
    /// EMR cluster VisibleToAllUsers
    /// setting](https://docs.aws.amazon.com/emr/latest/ManagementGuide/security_IAM_emr-with-IAM.html#security_set_visible_to_all_users) in the
    /// *Amazon EMR Management Guide*.
    visible_to_all_users: ?bool = null,

    pub const json_field_names = .{
        .additional_info = "AdditionalInfo",
        .ami_version = "AmiVersion",
        .applications = "Applications",
        .auto_scaling_role = "AutoScalingRole",
        .auto_termination_policy = "AutoTerminationPolicy",
        .bootstrap_actions = "BootstrapActions",
        .configurations = "Configurations",
        .custom_ami_id = "CustomAmiId",
        .ebs_root_volume_iops = "EbsRootVolumeIops",
        .ebs_root_volume_size = "EbsRootVolumeSize",
        .ebs_root_volume_throughput = "EbsRootVolumeThroughput",
        .extended_support = "ExtendedSupport",
        .instances = "Instances",
        .job_flow_role = "JobFlowRole",
        .kerberos_attributes = "KerberosAttributes",
        .log_encryption_kms_key_id = "LogEncryptionKmsKeyId",
        .log_uri = "LogUri",
        .managed_scaling_policy = "ManagedScalingPolicy",
        .monitoring_configuration = "MonitoringConfiguration",
        .name = "Name",
        .new_supported_products = "NewSupportedProducts",
        .os_release_label = "OSReleaseLabel",
        .placement_group_configs = "PlacementGroupConfigs",
        .release_label = "ReleaseLabel",
        .repo_upgrade_on_boot = "RepoUpgradeOnBoot",
        .scale_down_behavior = "ScaleDownBehavior",
        .security_configuration = "SecurityConfiguration",
        .service_role = "ServiceRole",
        .step_concurrency_level = "StepConcurrencyLevel",
        .step_execution_role_arn = "StepExecutionRoleArn",
        .steps = "Steps",
        .supported_products = "SupportedProducts",
        .tags = "Tags",
        .visible_to_all_users = "VisibleToAllUsers",
    };
};

pub const RunJobFlowOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// A unique identifier for the job flow.
    job_flow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .job_flow_id = "JobFlowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RunJobFlowInput, options: CallOptions) !RunJobFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticmapreduce");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RunJobFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.RunJobFlow");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RunJobFlowOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RunJobFlowOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
