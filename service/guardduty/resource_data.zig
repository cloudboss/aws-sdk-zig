const AccessKey = @import("access_key.zig").AccessKey;
const AutoscalingAutoScalingGroup = @import("autoscaling_auto_scaling_group.zig").AutoscalingAutoScalingGroup;
const CloudformationStack = @import("cloudformation_stack.zig").CloudformationStack;
const ContainerFindingResource = @import("container_finding_resource.zig").ContainerFindingResource;
const Ec2Image = @import("ec_2_image.zig").Ec2Image;
const Ec2Instance = @import("ec_2_instance.zig").Ec2Instance;
const Ec2LaunchTemplate = @import("ec_2_launch_template.zig").Ec2LaunchTemplate;
const Ec2NetworkInterface = @import("ec_2_network_interface.zig").Ec2NetworkInterface;
const Ec2Vpc = @import("ec_2_vpc.zig").Ec2Vpc;
const EcsCluster = @import("ecs_cluster.zig").EcsCluster;
const EcsTask = @import("ecs_task.zig").EcsTask;
const EksCluster = @import("eks_cluster.zig").EksCluster;
const IamInstanceProfileV2 = @import("iam_instance_profile_v2.zig").IamInstanceProfileV2;
const KubernetesWorkload = @import("kubernetes_workload.zig").KubernetesWorkload;
const S3Bucket = @import("s3_bucket.zig").S3Bucket;
const S3Object = @import("s3_object.zig").S3Object;

/// Contains information about the Amazon Web Services resource that is
/// associated with the activity that prompted GuardDuty to generate a finding.
pub const ResourceData = struct {
    /// Contains information about the IAM access key details of a user that
    /// involved in the GuardDuty finding.
    access_key: ?AccessKey = null,

    /// Contains detailed information about the Auto Scaling Group associated with
    /// the activity that prompted GuardDuty to generate a finding.
    autoscaling_auto_scaling_group: ?AutoscalingAutoScalingGroup = null,

    /// Contains detailed information about the CloudFormation stack associated with
    /// the activity that prompted GuardDuty to generate a finding.
    cloudformation_stack: ?CloudformationStack = null,

    /// Contains detailed information about the container associated with the
    /// activity that prompted GuardDuty to generate a finding.
    container: ?ContainerFindingResource = null,

    /// Contains detailed information about the EC2 Image associated with the
    /// activity that prompted GuardDuty to generate a finding.
    ec_2_image: ?Ec2Image = null,

    /// Contains information about the Amazon EC2 instance.
    ec_2_instance: ?Ec2Instance = null,

    /// Contains detailed information about the EC2 launch template associated with
    /// the activity that prompted GuardDuty to generate a finding.
    ec_2_launch_template: ?Ec2LaunchTemplate = null,

    /// Contains information about the elastic network interface of the Amazon EC2
    /// instance.
    ec_2_network_interface: ?Ec2NetworkInterface = null,

    /// Contains detailed information about the EC2 VPC associated with the activity
    /// that prompted GuardDuty to generate a finding.
    ec_2_vpc: ?Ec2Vpc = null,

    /// Contains detailed information about the Amazon ECS cluster associated with
    /// the activity that prompted GuardDuty to generate a finding.
    ecs_cluster: ?EcsCluster = null,

    /// Contains detailed information about the Amazon ECS task associated with the
    /// activity that prompted GuardDuty to generate a finding.
    ecs_task: ?EcsTask = null,

    /// Contains detailed information about the Amazon EKS cluster associated with
    /// the activity that prompted GuardDuty to generate a finding.
    eks_cluster: ?EksCluster = null,

    /// Contains detailed information about the IAM instance profile associated with
    /// the activity that prompted GuardDuty to generate a finding.
    iam_instance_profile: ?IamInstanceProfileV2 = null,

    /// Contains detailed information about the Kubernetes workload associated with
    /// the activity that prompted GuardDuty to generate a finding.
    kubernetes_workload: ?KubernetesWorkload = null,

    /// Contains information about the Amazon S3 bucket.
    s3_bucket: ?S3Bucket = null,

    /// Contains information about the Amazon S3 object.
    s3_object: ?S3Object = null,

    pub const json_field_names = .{
        .access_key = "AccessKey",
        .autoscaling_auto_scaling_group = "AutoscalingAutoScalingGroup",
        .cloudformation_stack = "CloudformationStack",
        .container = "Container",
        .ec_2_image = "Ec2Image",
        .ec_2_instance = "Ec2Instance",
        .ec_2_launch_template = "Ec2LaunchTemplate",
        .ec_2_network_interface = "Ec2NetworkInterface",
        .ec_2_vpc = "Ec2Vpc",
        .ecs_cluster = "EcsCluster",
        .ecs_task = "EcsTask",
        .eks_cluster = "EksCluster",
        .iam_instance_profile = "IamInstanceProfile",
        .kubernetes_workload = "KubernetesWorkload",
        .s3_bucket = "S3Bucket",
        .s3_object = "S3Object",
    };
};
