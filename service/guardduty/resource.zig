const AccessKeyDetails = @import("access_key_details.zig").AccessKeyDetails;
const Container = @import("container.zig").Container;
const EbsSnapshotDetails = @import("ebs_snapshot_details.zig").EbsSnapshotDetails;
const EbsVolumeDetails = @import("ebs_volume_details.zig").EbsVolumeDetails;
const Ec2ImageDetails = @import("ec_2_image_details.zig").Ec2ImageDetails;
const EcsClusterDetails = @import("ecs_cluster_details.zig").EcsClusterDetails;
const EksClusterDetails = @import("eks_cluster_details.zig").EksClusterDetails;
const InstanceDetails = @import("instance_details.zig").InstanceDetails;
const KubernetesDetails = @import("kubernetes_details.zig").KubernetesDetails;
const LambdaDetails = @import("lambda_details.zig").LambdaDetails;
const RdsDbInstanceDetails = @import("rds_db_instance_details.zig").RdsDbInstanceDetails;
const RdsDbUserDetails = @import("rds_db_user_details.zig").RdsDbUserDetails;
const RdsLimitlessDbDetails = @import("rds_limitless_db_details.zig").RdsLimitlessDbDetails;
const RecoveryPointDetails = @import("recovery_point_details.zig").RecoveryPointDetails;
const S3BucketDetail = @import("s3_bucket_detail.zig").S3BucketDetail;

/// Contains information about the Amazon Web Services resource associated with
/// the activity that prompted
/// GuardDuty to generate a finding.
pub const Resource = struct {
    /// The IAM access key details (user information) of a user that engaged in the
    /// activity that
    /// prompted GuardDuty to generate a finding.
    access_key_details: ?AccessKeyDetails,

    container_details: ?Container,

    /// Contains details about the EBS snapshot that was scanned.
    ebs_snapshot_details: ?EbsSnapshotDetails,

    /// Contains list of scanned and skipped EBS volumes with details.
    ebs_volume_details: ?EbsVolumeDetails,

    /// Contains details about the EC2 image that was scanned.
    ec_2_image_details: ?Ec2ImageDetails,

    /// Contains information about the details of the ECS Cluster.
    ecs_cluster_details: ?EcsClusterDetails,

    /// Details about the EKS cluster involved in a Kubernetes finding.
    eks_cluster_details: ?EksClusterDetails,

    /// The information about the EC2 instance associated with the activity that
    /// prompted
    /// GuardDuty to generate a finding.
    instance_details: ?InstanceDetails,

    /// Details about the Kubernetes user and workload involved in a Kubernetes
    /// finding.
    kubernetes_details: ?KubernetesDetails,

    /// Contains information about the Lambda function that was involved in a
    /// finding.
    lambda_details: ?LambdaDetails,

    /// Contains information about the database instance to which an anomalous login
    /// attempt was
    /// made.
    rds_db_instance_details: ?RdsDbInstanceDetails,

    /// Contains information about the user details through which anomalous login
    /// attempt was
    /// made.
    rds_db_user_details: ?RdsDbUserDetails,

    /// Contains information about the RDS Limitless database that was involved in a
    /// GuardDuty finding.
    rds_limitless_db_details: ?RdsLimitlessDbDetails,

    /// Contains details about the backup recovery point that was scanned.
    recovery_point_details: ?RecoveryPointDetails,

    /// The type of Amazon Web Services resource.
    resource_type: ?[]const u8,

    /// Contains information on the S3 bucket.
    s3_bucket_details: ?[]const S3BucketDetail,

    pub const json_field_names = .{
        .access_key_details = "AccessKeyDetails",
        .container_details = "ContainerDetails",
        .ebs_snapshot_details = "EbsSnapshotDetails",
        .ebs_volume_details = "EbsVolumeDetails",
        .ec_2_image_details = "Ec2ImageDetails",
        .ecs_cluster_details = "EcsClusterDetails",
        .eks_cluster_details = "EksClusterDetails",
        .instance_details = "InstanceDetails",
        .kubernetes_details = "KubernetesDetails",
        .lambda_details = "LambdaDetails",
        .rds_db_instance_details = "RdsDbInstanceDetails",
        .rds_db_user_details = "RdsDbUserDetails",
        .rds_limitless_db_details = "RdsLimitlessDbDetails",
        .recovery_point_details = "RecoveryPointDetails",
        .resource_type = "ResourceType",
        .s3_bucket_details = "S3BucketDetails",
    };
};
