/// Provides information used to select Amazon Machine Images (AMIs) for
/// instances in the
/// compute environment. If `Ec2Configuration` isn't specified, the default is
/// `ECS_AL2023` ([Amazon ECS-optimized Amazon Linux
/// 2023](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)) for EC2 (ECS) compute environments and `EKS_AL2023` ([Amazon EKS-optimized Amazon Linux 2023
/// AMI](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html)) for EKS compute environments.
///
/// This object isn't applicable to jobs that are running on Fargate resources.
pub const Ec2Configuration = struct {
    /// The status of the Batch-provided default AMIs associated with the
    /// `imageType`.
    ///
    /// The field only appears after the compute environment has begun scaling
    /// instances using the `imageType`. The field is not present when an image is
    /// specified in
    /// `ComputeResources.imageId` (deprecated), the default launch template, or
    /// `Ec2Configuration.imageIdOverride`. The field is also not present when the
    /// compute environment has a launch template override.
    ///
    /// For more information on image selection, see [AMI selection
    /// order](https://docs.aws.amazon.com/batch/latest/userguide/ami-selection-order.html).
    ///
    /// This field is read-only and only appears in the
    /// [DescribeComputeEnvironments](https://docs.aws.amazon.com/batch/latest/APIReference/API_DescribeComputeEnvironments.html) response.
    ///
    /// * `LATEST` − Using the most recent AMI supported
    ///
    /// * `UPDATE_AVAILABLE` − An updated AMI is available
    ///
    /// * If a compute environment has multiple AMIs for the `imageType` and any one
    ///   AMI has `UPDATE_AVAILABLE`, the status shows `UPDATE_AVAILABLE`.
    ///
    /// * For compute environments that use `BEST_FIT` as their allocation strategy,
    /// you can perform a [blue/green
    /// update](https://docs.aws.amazon.com/batch/latest/userguide/blue-green-updates.html) to update the AMI.
    ///
    /// * For all other compute environments, you can perform an
    /// [AMI version
    /// update](https://docs.aws.amazon.com/batch/latest/userguide/managing-ami-versions.html#updating-ami-versions) to update the AMI to the latest version.
    batch_image_status: ?[]const u8 = null,

    /// The AMI ID used for instances launched in the compute environment that match
    /// the image type.
    /// This setting overrides the `imageId` set in the `computeResource`
    /// object.
    ///
    /// The AMI that you choose for a compute environment must match the
    /// architecture of the instance types that
    /// you intend to use for that compute environment. For example, if your compute
    /// environment uses A1 instance types,
    /// the compute resource AMI that you choose must support ARM instances. Amazon
    /// ECS vends both x86 and ARM versions of the
    /// Amazon ECS-optimized Amazon Linux 2023 AMI. For more information, see
    /// [Amazon ECS-optimized
    /// Amazon Linux 2023
    /// AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#ecs-optimized-ami-linux-variants.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    image_id_override: ?[]const u8 = null,

    /// The Kubernetes version for the compute environment. If you don't specify a
    /// value, the latest
    /// version that Batch supports is used.
    image_kubernetes_version: ?[]const u8 = null,

    /// The image type to match with the instance type to select an AMI. The
    /// supported values are
    /// different for `ECS` and `EKS` resources.
    ///
    /// **ECS**
    ///
    /// If the `imageIdOverride` parameter isn't specified, then a recent [Amazon
    /// ECS-optimized Amazon Linux 2023
    /// AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) (`ECS_AL2023`) is used. If a new image type is
    /// specified in an update, but neither an `imageId` nor a `imageIdOverride`
    /// parameter is specified, then the latest Amazon ECS optimized AMI for that
    /// image type that's
    /// supported by Batch is used.
    ///
    /// Amazon Web Services is ending support for Amazon ECS Amazon Linux
    /// 2-optimized and accelerated AMIs on June 30,
    /// 2026. On January 12, 2026, Batch changed the default AMI for new Amazon ECS
    /// compute environments
    /// from Amazon Linux 2 to Amazon Linux 2023. Effective June 30, 2026, Batch
    /// will block creation
    /// of new Amazon ECS compute environments using Batch-provided Amazon Linux 2
    /// AMIs. We strongly recommend
    /// migrating your existing Batch Amazon ECS compute environments to Amazon
    /// Linux 2023 prior to June 30,
    /// 2026. For more information on upgrading from AL2 to AL2023, see [How to
    /// migrate
    /// from ECS AL2 to ECS
    /// AL2023](https://docs.aws.amazon.com/batch/latest/userguide/ecs-migration-2023.html) in the *Batch User Guide*.
    ///
    /// **ECS_AL2**
    ///
    /// [Amazon Linux
    /// 2](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html): Used for non-GPU instance families.
    ///
    /// **ECS_AL2_NVIDIA**
    ///
    /// [Amazon Linux 2
    /// (GPU)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#gpuami): Used for GPU instance families (for example `P4` and
    /// `G4`) and non Amazon Web Services Graviton-based instance types.
    ///
    /// **ECS_AL2023**
    ///
    /// [Amazon Linux
    /// 2023](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html): Default
    /// for all non-GPU instance families.
    ///
    /// Amazon Linux 2023 does not support `A1` instances.
    ///
    /// **ECS_AL2023_NVIDIA**
    ///
    /// [Amazon Linux 2023
    /// (GPU)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#gpuami): Default for all GPU instance families and can be used for all non Amazon Web Services Graviton-based instance types.
    ///
    /// ECS_AL2023_NVIDIA doesn't support `p3` and `g3` instance types.
    ///
    /// **EKS**
    ///
    /// If the `imageIdOverride` parameter isn't specified, then a recent [Amazon
    /// EKS-optimized Amazon Linux 2023
    /// AMI](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html) (`EKS_AL2023`) is used. If a new image type is specified in an update,
    /// but neither an `imageId` nor a `imageIdOverride` parameter is specified,
    /// then the latest Amazon EKS optimized AMI for that image type that Batch
    /// supports is used.
    ///
    /// Amazon Linux 2023 AMIs are the
    /// default on Batch for Amazon EKS.
    ///
    /// Amazon Web Services ended support for Amazon EKS AL2-optimized and
    /// AL2-accelerated AMIs on November 26,
    /// 2025. Batch Amazon EKS compute environments using Amazon Linux 2 will no
    /// longer receive software
    /// updates, security patches, or bug fixes from Amazon Web Services. We
    /// recommend migrating to Amazon Linux
    /// 2023. For more information on upgrading from AL2 to AL2023, see [How to
    /// upgrade from EKS AL2 to EKS
    /// AL2023](https://docs.aws.amazon.com/batch/latest/userguide/eks-migration-2023.html) in the *Batch User Guide*.
    ///
    /// **EKS_AL2**
    ///
    /// [Amazon
    /// Linux
    /// 2](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html):
    /// Used for non-GPU instance families.
    ///
    /// **EKS_AL2_NVIDIA**
    ///
    /// [Amazon
    /// Linux 2
    /// (accelerated)](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html): Used for GPU instance families (for example,
    /// `P4` and `G4`) and can be used for all non Amazon Web Services
    /// Graviton-based
    /// instance types.
    ///
    /// **EKS_AL2023**
    ///
    /// [Amazon
    /// Linux
    /// 2023](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html): Default for non-GPU instance families.
    ///
    /// Amazon Linux 2023 does not support `A1` instances.
    ///
    /// **EKS_AL2023_NVIDIA**
    ///
    /// [Amazon
    /// Linux 2023
    /// (accelerated)](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html): Default for GPU instance families and can be used for all non Amazon Web Services
    /// Graviton-based instance types.
    image_type: []const u8,

    pub const json_field_names = .{
        .batch_image_status = "batchImageStatus",
        .image_id_override = "imageIdOverride",
        .image_kubernetes_version = "imageKubernetesVersion",
        .image_type = "imageType",
    };
};
