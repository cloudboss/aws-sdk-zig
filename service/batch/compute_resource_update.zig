const aws = @import("aws");

const CRUpdateAllocationStrategy = @import("cr_update_allocation_strategy.zig").CRUpdateAllocationStrategy;
const Ec2Configuration = @import("ec_2_configuration.zig").Ec2Configuration;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const CRType = @import("cr_type.zig").CRType;

/// An object that represents the attributes of a compute environment that can
/// be updated. For
/// more information, see [Updating compute
/// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
/// *Batch User Guide*.
pub const ComputeResourceUpdate = struct {
    /// The allocation strategy to use for the compute resource if there's not
    /// enough instances of
    /// the best fitting instance type that can be allocated. This might be because
    /// of availability of
    /// the instance type in the Region or [Amazon EC2 service
    /// limits](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html). For more
    /// information, see [Allocation
    /// strategies](https://docs.aws.amazon.com/batch/latest/userguide/allocation-strategies.html) in the *Batch User Guide*.
    ///
    /// When updating a compute environment, changing the allocation strategy
    /// requires an
    /// infrastructure update of the compute environment. For more information, see
    /// [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the *Batch User Guide*. `BEST_FIT` isn't
    /// supported when updating a compute environment.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    ///
    /// **BEST_FIT_PROGRESSIVE**
    ///
    /// Batch selects additional instance types that are large enough to meet the
    /// requirements
    /// of the jobs in the queue. Its preference is for instance types with lower
    /// cost vCPUs. If
    /// additional instances of the previously selected instance types aren't
    /// available, Batch
    /// selects new instance types.
    ///
    /// **SPOT_CAPACITY_OPTIMIZED**
    ///
    /// Batch selects one or more instance types that are large enough to meet the
    /// requirements
    /// of the jobs in the queue. Its preference is for instance types that are less
    /// likely to be
    /// interrupted. This allocation strategy is only available for Spot Instance
    /// compute
    /// resources.
    ///
    /// **SPOT_PRICE_CAPACITY_OPTIMIZED**
    ///
    /// The price and capacity optimized allocation strategy looks at both price and
    /// capacity to
    /// select the Spot Instance pools that are the least likely to be interrupted
    /// and have the lowest
    /// possible price. This allocation strategy is only available for Spot Instance
    /// compute
    /// resources.
    ///
    /// With `BEST_FIT_PROGRESSIVE`,`SPOT_CAPACITY_OPTIMIZED` and
    /// `SPOT_PRICE_CAPACITY_OPTIMIZED` (recommended) strategies using On-Demand or
    /// Spot Instances,
    /// and the `BEST_FIT` strategy using Spot Instances, Batch might need to exceed
    /// `maxvCpus` to meet your capacity requirements. In this event, Batch never
    /// exceeds
    /// `maxvCpus` by more than a single instance.
    allocation_strategy: ?CRUpdateAllocationStrategy,

    /// The maximum percentage that a Spot Instance price can be when compared with
    /// the On-Demand
    /// price for that instance type before instances are launched. For example, if
    /// your maximum
    /// percentage is 20%, the Spot price must be less than 20% of the current
    /// On-Demand price for that
    /// Amazon EC2 instance. You always pay the lowest (market) price and never more
    /// than your maximum
    /// percentage. For most use cases, we recommend leaving this field empty.
    ///
    /// When updating a compute environment, changing the bid percentage requires an
    /// infrastructure
    /// update of the compute environment. For more information, see [Updating
    /// compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    bid_percentage: ?i32,

    /// The desired number of vCPUS in the compute environment. Batch modifies this
    /// value between
    /// the minimum and maximum values based on job queue demand.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    ///
    /// Batch doesn't support changing the desired number of vCPUs of an existing
    /// compute
    /// environment. Don't specify this parameter for compute environments using
    /// Amazon EKS clusters.
    ///
    /// When you update the `desiredvCpus` setting, the value must be between the
    /// `minvCpus` and `maxvCpus` values.
    ///
    /// Additionally, the updated `desiredvCpus` value must be greater than or equal
    /// to
    /// the current `desiredvCpus` value. For more information, see [Troubleshooting
    /// Batch](https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#error-desired-vcpus-update) in the *Batch User Guide*.
    desiredv_cpus: ?i32,

    /// Provides information used to select Amazon Machine Images (AMIs) for Amazon
    /// EC2 instances in the
    /// compute environment. If `Ec2Configuration` isn't specified, the default is
    /// `ECS_AL2`.
    ///
    /// When updating a compute environment, changing this setting requires an
    /// infrastructure update
    /// of the compute environment. For more information, see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*. To remove the Amazon EC2 configuration and any custom
    /// AMI ID
    /// specified in `imageIdOverride`, set this value to an empty string.
    ///
    /// One or two values can be provided.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    ec_2_configuration: ?[]const Ec2Configuration,

    /// The Amazon EC2 key pair that's used for instances launched in the compute
    /// environment. You can
    /// use this key pair to log in to your instances with SSH. To remove the Amazon
    /// EC2 key pair, set this
    /// value to an empty string.
    ///
    /// When updating a compute environment, changing the Amazon EC2 key pair
    /// requires an infrastructure
    /// update of the compute environment. For more information, see [Updating
    /// compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    ec_2_key_pair: ?[]const u8,

    /// The Amazon Machine Image (AMI) ID used for instances launched in the compute
    /// environment.
    /// This parameter is overridden by the `imageIdOverride` member of the
    /// `Ec2Configuration` structure. To remove the custom AMI ID and use the
    /// default AMI ID,
    /// set this value to an empty string.
    ///
    /// When updating a compute environment, changing the AMI ID requires an
    /// infrastructure update
    /// of the compute environment. For more information, see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    ///
    /// The AMI that you choose for a compute environment must match the
    /// architecture of the instance types that
    /// you intend to use for that compute environment. For example, if your compute
    /// environment uses A1 instance types,
    /// the compute resource AMI that you choose must support ARM instances. Amazon
    /// ECS vends both x86 and ARM versions of the
    /// Amazon ECS-optimized Amazon Linux 2 AMI. For more information, see [Amazon
    /// ECS-optimized
    /// Amazon Linux 2
    /// AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#ecs-optimized-ami-linux-variants.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    image_id: ?[]const u8,

    /// The Amazon ECS instance profile applied to Amazon EC2 instances in a compute
    /// environment.
    /// Required for Amazon EC2 instances. You can specify the short name or full
    /// Amazon Resource Name (ARN) of an instance
    /// profile. For example, `
    /// *ecsInstanceRole*
    /// ` or
    /// `arn:aws:iam::**:instance-profile/*ecsInstanceRole*
    /// `.
    /// For more information, see [Amazon ECS instance
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/instance_IAM_role.html) in the *Batch User Guide*.
    ///
    /// When updating a compute environment, changing this setting requires an
    /// infrastructure update
    /// of the compute environment. For more information, see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    instance_role: ?[]const u8,

    /// The instances types that can be launched. You can specify instance families
    /// to launch any
    /// instance type within those families (for example, `c5` or `p3`), or you can
    /// specify specific sizes within a family (such as `c5.8xlarge`).
    ///
    /// Batch can select the instance type for you if you choose one of the
    /// following:
    ///
    /// * `optimal` to select instance types (from the `c4`, `m4`,
    /// `r4`, `c5`, `m5`, and `r5`
    /// instance families) that match the demand of your job queues.
    ///
    /// * `default_x86_64` to choose x86 based instance types (from the `m6i`,
    /// `c6i`, `r6i`, and `c7i` instance families) that matches the resource demands
    /// of the job queue.
    ///
    /// * `default_arm64` to choose x86 based instance types (from the `m6g`,
    /// `c6g`, `r6g`, and `c7g` instance families) that matches the resource demands
    /// of the job queue.
    ///
    /// Starting on 11/01/2025 the behavior of `optimal` is going to be changed to
    /// match
    /// `default_x86_64`. During the change your instance families could be updated
    /// to a
    /// newer generation. You do not need to perform any actions for the upgrade to
    /// happen. For more
    /// information about change, see [Optimal instance type configuration to
    /// receive automatic instance family
    /// updates](https://docs.aws.amazon.com/batch/latest/userguide/optimal-default-instance-troubleshooting.html).
    ///
    /// Instance family availability varies by Amazon Web Services Region. For
    /// example, some Amazon Web Services Regions may not have any fourth generation
    /// instance families but have fifth and
    /// sixth generation instance families.
    ///
    /// When using `default_x86_64` or `default_arm64` instance bundles,
    /// Batch selects instance families based on a balance of cost-effectiveness and
    /// performance.
    /// While newer generation instances often provide better price-performance,
    /// Batch may choose an
    /// earlier generation instance family if it provides the optimal combination of
    /// availability, cost,
    /// and performance for your workload. For example, in an Amazon Web Services
    /// Region where both c6i
    /// and c7i instances are available, Batch might select c6i instances if they
    /// offer better
    /// cost-effectiveness for your specific job requirements. For more information
    /// on Batch instance
    /// types and Amazon Web Services Region availability, see [Instance
    /// type compute
    /// table](https://docs.aws.amazon.com/batch/latest/userguide/instance-type-compute-table.html) in the *Batch User Guide*.
    ///
    /// Batch periodically updates your instances in default bundles to newer,
    /// more cost-effective options. Updates happen automatically without requiring
    /// any
    /// action from you. Your workloads continue running during updates with no
    /// interruption
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    ///
    /// When you create a compute environment, the instance types that you select
    /// for the compute environment must
    /// share the same architecture. For example, you can't mix x86 and ARM
    /// instances in the same compute
    /// environment.
    instance_types: ?[]const []const u8,

    /// The updated launch template to use for your compute resources. You must
    /// specify either the
    /// launch template ID or launch template name in the request, but not both. For
    /// more information,
    /// see [Launch template
    /// support](https://docs.aws.amazon.com/batch/latest/userguide/launch-templates.html) in the *Batch User Guide*. To remove the custom launch
    /// template and use the default launch template, set `launchTemplateId` or
    /// `launchTemplateName` member of the launch template specification to an empty
    /// string.
    /// Removing the launch template from a compute environment will not remove the
    /// AMI specified in the
    /// launch template. In order to update the AMI specified in a launch template,
    /// the
    /// `updateToLatestImageVersion` parameter must be set to `true`.
    ///
    /// When updating a compute environment, changing the launch template requires
    /// an infrastructure
    /// update of the compute environment. For more information, see [Updating
    /// compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    launch_template: ?LaunchTemplateSpecification,

    /// The maximum number of Amazon EC2 vCPUs that an environment can reach.
    ///
    /// With `BEST_FIT_PROGRESSIVE`,`SPOT_CAPACITY_OPTIMIZED` and
    /// `SPOT_PRICE_CAPACITY_OPTIMIZED` (recommended) strategies using On-Demand or
    /// Spot
    /// Instances, and the `BEST_FIT` strategy using Spot Instances, Batch might
    /// need to
    /// exceed `maxvCpus` to meet your capacity requirements. In this event, Batch
    /// never
    /// exceeds `maxvCpus` by more than a single instance.
    maxv_cpus: ?i32,

    /// The minimum number of vCPUs that an environment should maintain (even if the
    /// compute environment
    /// is `DISABLED`).
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    minv_cpus: ?i32,

    /// The Amazon EC2 placement group to associate with your compute resources. If
    /// you intend to submit
    /// multi-node parallel jobs to your compute environment, you should consider
    /// creating a cluster
    /// placement group and associate it with your compute resources. This keeps
    /// your multi-node parallel
    /// job on a logical grouping of instances within a single Availability Zone
    /// with high network flow
    /// potential. For more information, see [Placement
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the
    /// *Amazon EC2 User Guide for Linux Instances*.
    ///
    /// When updating a compute environment, changing the placement group requires
    /// an infrastructure
    /// update of the compute environment. For more information, see [Updating
    /// compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    placement_group: ?[]const u8,

    /// The Amazon EC2 security groups that are associated with instances launched
    /// in the compute
    /// environment. This parameter is required for Fargate compute resources, where
    /// it can contain up
    /// to 5 security groups. For Fargate compute resources, providing an empty list
    /// is handled as if
    /// this parameter wasn't specified and no change is made. For Amazon EC2
    /// compute resources, providing an
    /// empty list removes the security groups from the compute resource.
    ///
    /// When updating a compute environment, changing the Amazon EC2 security groups
    /// requires an
    /// infrastructure update of the compute environment. For more information, see
    /// [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the *Batch User Guide*.
    security_group_ids: ?[]const []const u8,

    /// The VPC subnets where the compute resources are launched. Fargate compute
    /// resources can
    /// contain up to 16 subnets. For Fargate compute resources, providing an empty
    /// list will be
    /// handled as if this parameter wasn't specified and no change is made. For
    /// Amazon EC2 compute resources,
    /// providing an empty list removes the VPC subnets from the compute resource.
    /// For more information,
    /// see [VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)
    /// in the *Amazon VPC User Guide*.
    ///
    /// When updating a compute environment, changing the VPC subnets requires an
    /// infrastructure
    /// update of the compute environment. For more information, see [Updating
    /// compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// Batch on Amazon EC2 and Batch on Amazon EKS support Local Zones. For more
    /// information, see [ Local
    /// Zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-local-zones) in the *Amazon EC2 User Guide for Linux Instances*, [Amazon EKS and Amazon Web Services Local
    /// Zones](https://docs.aws.amazon.com/eks/latest/userguide/local-zones.html) in
    /// the *Amazon EKS User Guide* and [ Amazon ECS
    /// clusters in Local Zones, Wavelength Zones, and Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-regions-zones.html#clusters-local-zones) in the *Amazon ECS
    /// Developer Guide*.
    ///
    /// Batch on Fargate doesn't currently support Local Zones.
    subnets: ?[]const []const u8,

    /// Key-value pair tags to be applied to Amazon EC2 resources that are launched
    /// in the compute
    /// environment. For Batch, these take the form of `"String1": "String2"`, where
    /// `String1` is the tag key and `String2` is the tag value (for example,
    /// `{ "Name": "Batch Instance - C4OnDemand" }`). This is helpful for
    /// recognizing your
    /// Batch instances in the Amazon EC2 console. These tags aren't seen when using
    /// the Batch
    /// `ListTagsForResource` API operation.
    ///
    /// When updating a compute environment, changing this setting requires an
    /// infrastructure update
    /// of the compute environment. For more information, see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    ///
    /// This parameter isn't applicable to jobs that are running on Fargate
    /// resources. Don't specify it.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of compute environment: `EC2`, `SPOT`, `FARGATE`,
    /// or `FARGATE_SPOT`. For more information, see [Compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html) in the
    /// *Batch User Guide*.
    ///
    /// If you choose `SPOT`, you must also specify an Amazon EC2 Spot Fleet role
    /// with the
    /// `spotIamFleetRole` parameter. For more information, see [Amazon EC2 spot
    /// fleet
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/spot_fleet_IAM_role.html) in the
    /// *Batch User Guide*.
    ///
    /// When updating a compute environment, changing the type of a compute
    /// environment requires an
    /// infrastructure update of the compute environment. For more information, see
    /// [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the *Batch User Guide*.
    @"type": ?CRType,

    /// Specifies whether the AMI ID is updated to the latest one that's supported
    /// by Batch when
    /// the compute environment has an infrastructure update. The default value is
    /// `false`.
    ///
    /// An AMI ID can either be specified in the `imageId` or
    /// `imageIdOverride` parameters or be determined by the launch template that's
    /// specified in the `launchTemplate` parameter. If an AMI ID is specified any
    /// of these
    /// ways, this parameter is ignored. For more information about to update AMI
    /// IDs during an
    /// infrastructure update, see [Updating
    /// the AMI
    /// ID](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html#updating-compute-environments-ami) in the *Batch User Guide*.
    ///
    /// When updating a compute environment, changing this setting requires an
    /// infrastructure update
    /// of the compute environment. For more information, see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    update_to_latest_image_version: ?bool,

    pub const json_field_names = .{
        .allocation_strategy = "allocationStrategy",
        .bid_percentage = "bidPercentage",
        .desiredv_cpus = "desiredvCpus",
        .ec_2_configuration = "ec2Configuration",
        .ec_2_key_pair = "ec2KeyPair",
        .image_id = "imageId",
        .instance_role = "instanceRole",
        .instance_types = "instanceTypes",
        .launch_template = "launchTemplate",
        .maxv_cpus = "maxvCpus",
        .minv_cpus = "minvCpus",
        .placement_group = "placementGroup",
        .security_group_ids = "securityGroupIds",
        .subnets = "subnets",
        .tags = "tags",
        .@"type" = "type",
        .update_to_latest_image_version = "updateToLatestImageVersion",
    };
};
