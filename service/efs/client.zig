const aws = @import("aws");
const std = @import("std");

const create_access_point = @import("create_access_point.zig");
const create_file_system = @import("create_file_system.zig");
const create_mount_target = @import("create_mount_target.zig");
const create_replication_configuration = @import("create_replication_configuration.zig");
const create_tags = @import("create_tags.zig");
const delete_access_point = @import("delete_access_point.zig");
const delete_file_system = @import("delete_file_system.zig");
const delete_file_system_policy = @import("delete_file_system_policy.zig");
const delete_mount_target = @import("delete_mount_target.zig");
const delete_replication_configuration = @import("delete_replication_configuration.zig");
const delete_tags = @import("delete_tags.zig");
const describe_access_points = @import("describe_access_points.zig");
const describe_account_preferences = @import("describe_account_preferences.zig");
const describe_backup_policy = @import("describe_backup_policy.zig");
const describe_file_system_policy = @import("describe_file_system_policy.zig");
const describe_file_systems = @import("describe_file_systems.zig");
const describe_lifecycle_configuration = @import("describe_lifecycle_configuration.zig");
const describe_mount_target_security_groups = @import("describe_mount_target_security_groups.zig");
const describe_mount_targets = @import("describe_mount_targets.zig");
const describe_replication_configurations = @import("describe_replication_configurations.zig");
const describe_tags = @import("describe_tags.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_mount_target_security_groups = @import("modify_mount_target_security_groups.zig");
const put_account_preferences = @import("put_account_preferences.zig");
const put_backup_policy = @import("put_backup_policy.zig");
const put_file_system_policy = @import("put_file_system_policy.zig");
const put_lifecycle_configuration = @import("put_lifecycle_configuration.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_file_system = @import("update_file_system.zig");
const update_file_system_protection = @import("update_file_system_protection.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EFS";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates an EFS access point. An access point is an application-specific view
    /// into an EFS file system that applies an operating system user and group, and
    /// a file
    /// system path, to any file system request made through the access point. The
    /// operating system
    /// user and group override any identity information provided by the NFS client.
    /// The file system
    /// path is exposed as the access point's root directory. Applications using the
    /// access point can
    /// only access data in the application's own directory and any subdirectories.
    /// A file system can
    /// have a maximum of 10,000 access points unless you request an increase. To
    /// learn more, see
    /// [Mounting a file
    /// system using EFS access
    /// points](https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html).
    ///
    /// If multiple requests to create access points on the same file system are
    /// sent in quick
    /// succession, and the file system is near the limit of access points, you may
    /// experience a
    /// throttling response for these requests. This is to ensure that the file
    /// system does not
    /// exceed the stated access point limit.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:CreateAccessPoint` action.
    ///
    /// Access points can be tagged on creation. If tags are specified in the
    /// creation action, IAM
    /// performs additional authorization on the `elasticfilesystem:TagResource`
    /// action to
    /// verify if users have permissions to create tags. Therefore, you must grant
    /// explicit
    /// permissions to use the `elasticfilesystem:TagResource` action. For more
    /// information, see [Granting
    /// permissions to tag resources during
    /// creation](https://docs.aws.amazon.com/efs/latest/ug/using-tags-efs.html#supported-iam-actions-tagging.html).
    pub fn createAccessPoint(self: *Self, allocator: std.mem.Allocator, input: create_access_point.CreateAccessPointInput, options: CallOptions) !create_access_point.CreateAccessPointOutput {
        return create_access_point.execute(self, allocator, input, options);
    }

    /// Creates a new, empty file system. The operation requires a creation token in
    /// the
    /// request that Amazon EFS uses to ensure idempotent creation (calling the
    /// operation with same
    /// creation token has no effect). If a file system does not currently exist
    /// that is owned by the
    /// caller's Amazon Web Services account with the specified creation token, this
    /// operation does the
    /// following:
    ///
    /// * Creates a new, empty file system. The file system will have an Amazon EFS
    ///   assigned
    /// ID, and an initial lifecycle state `creating`.
    ///
    /// * Returns with the description of the created file system.
    ///
    /// Otherwise, this operation returns a `FileSystemAlreadyExists` error with the
    /// ID of the existing file system.
    ///
    /// For basic use cases, you can use a randomly generated UUID for the creation
    /// token.
    ///
    /// The idempotent operation allows you to retry a `CreateFileSystem` call
    /// without
    /// risk of creating an extra file system. This can happen when an initial call
    /// fails in a way
    /// that leaves it uncertain whether or not a file system was actually created.
    /// An example might
    /// be that a transport level timeout occurred or your connection was reset. As
    /// long as you use
    /// the same creation token, if the initial call had succeeded in creating a
    /// file system, the
    /// client can learn of its existence from the `FileSystemAlreadyExists` error.
    ///
    /// For more information, see
    /// [Creating a file
    /// system](https://docs.aws.amazon.com/efs/latest/ug/creating-using-create-fs.html#creating-using-create-fs-part1)
    /// in the *Amazon EFS User Guide*.
    ///
    /// The `CreateFileSystem` call returns while the file system's lifecycle
    /// state is still `creating`. You can check the file system creation status by
    /// calling the DescribeFileSystems operation, which among other things returns
    /// the file
    /// system state.
    ///
    /// This operation accepts an optional `PerformanceMode` parameter that you
    /// choose
    /// for your file system. We recommend `generalPurpose`
    /// `PerformanceMode` for all file
    /// systems. The `maxIO` mode is a previous generation performance type that is
    /// designed for highly parallelized workloads that can tolerate higher
    /// latencies
    /// than the `generalPurpose` mode. `MaxIO` mode is not supported for One Zone
    /// file systems or
    /// file systems that use Elastic throughput.
    ///
    /// The `PerformanceMode` can't be changed after the file system has been
    /// created. For more information, see [Amazon EFS performance
    /// modes](https://docs.aws.amazon.com/efs/latest/ug/performance.html#performancemodes.html).
    ///
    /// You can set the throughput mode for the file system using the
    /// `ThroughputMode`
    /// parameter.
    ///
    /// After the file system is fully created, Amazon EFS sets its lifecycle state
    /// to
    /// `available`, at which point you can create one or more mount targets for the
    /// file
    /// system in your VPC. For more information, see CreateMountTarget. You mount
    /// your Amazon EFS file system on an EC2 instances in your VPC by using the
    /// mount
    /// target. For more information, see [Amazon EFS: How it
    /// Works](https://docs.aws.amazon.com/efs/latest/ug/how-it-works.html).
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:CreateFileSystem` action.
    ///
    /// File systems can be tagged on creation. If tags are specified in the
    /// creation action, IAM
    /// performs additional authorization on the `elasticfilesystem:TagResource`
    /// action to
    /// verify if users have permissions to create tags. Therefore, you must grant
    /// explicit
    /// permissions to use the `elasticfilesystem:TagResource` action. For more
    /// information, see [Granting permissions to tag resources during
    /// creation](https://docs.aws.amazon.com/efs/latest/ug/using-tags-efs.html#supported-iam-actions-tagging.html).
    pub fn createFileSystem(self: *Self, allocator: std.mem.Allocator, input: create_file_system.CreateFileSystemInput, options: CallOptions) !create_file_system.CreateFileSystemOutput {
        return create_file_system.execute(self, allocator, input, options);
    }

    /// Creates a mount target for a file system. You can then mount the file system
    /// on EC2
    /// instances by using the mount target.
    ///
    /// You can create one mount target in each Availability Zone in your VPC. All
    /// EC2 instances
    /// in a VPC within a given Availability Zone share a single mount target for a
    /// given file system. If
    /// you have multiple subnets in an Availability Zone, you create a mount target
    /// in one of the subnets.
    /// EC2 instances do not need to be in the same subnet as the mount target in
    /// order to
    /// access their file system.
    ///
    /// You can create only one mount target for a One Zone file system. You must
    /// create that mount target in the same Availability Zone in which the file
    /// system is located. Use the
    /// `AvailabilityZoneName` and `AvailabiltyZoneId` properties in the
    /// DescribeFileSystems response object to get this information. Use the
    /// `subnetId` associated with the file system's Availability Zone when creating
    /// the mount
    /// target.
    ///
    /// For more information, see [Amazon EFS: How it
    /// Works](https://docs.aws.amazon.com/efs/latest/ug/how-it-works.html).
    ///
    /// To create a mount target for a file system, the file system's lifecycle
    /// state must be
    /// `available`. For more information, see DescribeFileSystems.
    ///
    /// In the request, provide the following:
    ///
    /// * The file system ID for which you are creating the mount
    /// target.
    ///
    /// * A subnet ID, which determines the following:
    ///
    /// * The VPC in which Amazon EFS creates the mount target
    ///
    /// * The Availability Zone in which Amazon EFS creates the mount target
    ///
    /// * The IP address range from which Amazon EFS selects the IP address of the
    ///   mount target
    /// (if you don't specify an IP address in the request)
    ///
    /// After creating the mount target, Amazon EFS returns a response that
    /// includes, a
    /// `MountTargetId` and an `IpAddress`. You use this IP address when
    /// mounting the file system in an EC2 instance. You can also use the mount
    /// target's
    /// DNS name when mounting the file system. The EC2 instance on which you mount
    /// the file
    /// system by using the mount target can resolve the mount target's DNS name to
    /// its IP
    /// address. For more information, see [How it Works:
    /// Implementation
    /// Overview](https://docs.aws.amazon.com/efs/latest/ug/how-it-works.html#how-it-works-implementation).
    ///
    /// Note that you can create mount targets for a file system in only one VPC,
    /// and there can be
    /// only one mount target per Availability Zone. That is, if the file system
    /// already has one or more
    /// mount targets created for it, the subnet specified in the request to add
    /// another mount target
    /// must meet the following requirements:
    ///
    /// * Must belong to the same VPC as the subnets of the existing mount targets
    ///
    /// * Must not be in the same Availability Zone as any of the subnets of the
    ///   existing mount
    /// targets
    ///
    /// If the request satisfies the requirements, Amazon EFS does the following:
    ///
    /// * Creates a new mount target in the specified subnet.
    ///
    /// * Also creates a new network interface in the subnet as follows:
    ///
    /// * If the request provides an `IpAddress`, Amazon EFS assigns that
    /// IP address to the network interface. Otherwise, Amazon EFS assigns a free
    /// address in the subnet (in the same way that the Amazon EC2
    /// `CreateNetworkInterface` call does when a request does not specify a
    /// primary private IP address).
    ///
    /// * If the request provides `SecurityGroups`, this network interface is
    /// associated with those security groups. Otherwise, it belongs to the default
    /// security
    /// group for the subnet's VPC.
    ///
    /// * Assigns the description `Mount target *fsmt-id* for
    /// file system *fs-id*
    /// ` where `
    /// *fsmt-id*
    /// ` is the mount target ID, and `
    /// *fs-id*
    /// ` is the `FileSystemId`.
    ///
    /// * Sets the `requesterManaged` property of the network interface to
    /// `true`, and the `requesterId` value to
    /// `EFS`.
    ///
    /// Each Amazon EFS mount target has one corresponding requester-managed
    /// EC2 network interface. After the network interface is created, Amazon EFS
    /// sets the `NetworkInterfaceId` field in the mount target's description to
    /// the network interface ID, and the `IpAddress` field to its address. If
    /// network
    /// interface creation fails, the entire `CreateMountTarget` operation
    /// fails.
    ///
    /// The `CreateMountTarget` call returns only after creating the network
    /// interface, but while the mount target state is still `creating`, you can
    /// check
    /// the mount target creation status by calling the DescribeMountTargets
    /// operation, which among other things returns the mount
    /// target state.
    ///
    /// We recommend that you create a mount target in each of the Availability
    /// Zones. There are cost
    /// considerations for using a file system in an Availability Zone through a
    /// mount target created in
    /// another Availability Zone. For more information, see [Amazon EFS
    /// pricing](http://aws.amazon.com/efs/pricing/). In addition, by always using a
    /// mount target local to the
    /// instance's Availability Zone, you eliminate a partial failure scenario. If
    /// the Availability Zone in
    /// which your mount target is created goes down, then you can't access your
    /// file system
    /// through that mount target.
    ///
    /// This operation requires permissions for the following action on the file
    /// system:
    ///
    /// * `elasticfilesystem:CreateMountTarget`
    ///
    /// This operation also requires permissions for the following Amazon EC2
    /// actions:
    ///
    /// * `ec2:DescribeSubnets`
    ///
    /// * `ec2:DescribeNetworkInterfaces`
    ///
    /// * `ec2:CreateNetworkInterface`
    pub fn createMountTarget(self: *Self, allocator: std.mem.Allocator, input: create_mount_target.CreateMountTargetInput, options: CallOptions) !create_mount_target.CreateMountTargetOutput {
        return create_mount_target.execute(self, allocator, input, options);
    }

    /// Creates a replication conﬁguration to either a new or existing EFS file
    /// system.
    /// For more information, see [Amazon EFS
    /// replication](https://docs.aws.amazon.com/efs/latest/ug/efs-replication.html)
    /// in the *Amazon EFS User
    /// Guide*. The replication configuration specifies the following:
    ///
    /// * **Source file system** – The EFS file
    /// system that you want to replicate.
    ///
    /// * **Destination file system** – The destination file
    /// system to which the source file system is replicated. There can only be one
    /// destination
    /// file system in a replication configuration.
    ///
    /// A file system can be part of only one replication configuration.
    ///
    /// The destination parameters for the replication configuration depend on
    /// whether you are replicating to a new file system or to an existing file
    /// system, and if you
    /// are replicating across Amazon Web Services accounts. See DestinationToCreate
    /// for more information.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:CreateReplicationConfiguration`
    /// action. Additionally, other permissions are required depending on how you
    /// are replicating file systems.
    /// For more information, see [Required permissions for
    /// replication](https://docs.aws.amazon.com/efs/latest/ug/efs-replication.html#efs-replication-permissions)
    /// in the *Amazon EFS User
    /// Guide*.
    pub fn createReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_replication_configuration.CreateReplicationConfigurationInput, options: CallOptions) !create_replication_configuration.CreateReplicationConfigurationOutput {
        return create_replication_configuration.execute(self, allocator, input, options);
    }

    /// DEPRECATED - `CreateTags` is deprecated and not maintained. To create tags
    /// for EFS
    /// resources, use the API action.
    ///
    /// Creates or overwrites tags associated with a file system. Each tag is a
    /// key-value pair. If
    /// a tag key specified in the request already exists on the file system, this
    /// operation
    /// overwrites its value with the value provided in the request. If you add the
    /// `Name`
    /// tag to your file system, Amazon EFS returns it in the response to the
    /// DescribeFileSystems operation.
    ///
    /// This operation requires permission for the `elasticfilesystem:CreateTags`
    /// action.
    pub fn createTags(self: *Self, allocator: std.mem.Allocator, input: create_tags.CreateTagsInput, options: CallOptions) !create_tags.CreateTagsOutput {
        return create_tags.execute(self, allocator, input, options);
    }

    /// Deletes the specified access point. After deletion is complete, new clients
    /// can no
    /// longer connect to the access points. Clients connected to the access point
    /// at the time of
    /// deletion will continue to function until they terminate their connection.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DeleteAccessPoint` action.
    pub fn deleteAccessPoint(self: *Self, allocator: std.mem.Allocator, input: delete_access_point.DeleteAccessPointInput, options: CallOptions) !delete_access_point.DeleteAccessPointOutput {
        return delete_access_point.execute(self, allocator, input, options);
    }

    /// Deletes a file system, permanently severing access to its contents. Upon
    /// return, the
    /// file system no longer exists and you can't access any contents of the
    /// deleted file
    /// system.
    ///
    /// You need to manually delete mount targets attached to a file system before
    /// you can delete
    /// an EFS file system. This step is performed for you when you use the Amazon
    /// Web Services console
    /// to delete a file system.
    ///
    /// You cannot delete a file system that is part of an EFS replication
    /// configuration.
    /// You need to delete the replication configuration first.
    ///
    /// You can't delete a file system that is in use. That is, if the file system
    /// has
    /// any mount targets, you must first delete them. For more information, see
    /// DescribeMountTargets and DeleteMountTarget.
    ///
    /// The `DeleteFileSystem` call returns while the file system state is still
    /// `deleting`. You can check the file system deletion status by calling the
    /// DescribeFileSystems operation, which returns a list of file systems in your
    /// account. If you pass file system ID or creation token for the deleted file
    /// system, the DescribeFileSystems returns a `404 FileSystemNotFound`
    /// error.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DeleteFileSystem` action.
    pub fn deleteFileSystem(self: *Self, allocator: std.mem.Allocator, input: delete_file_system.DeleteFileSystemInput, options: CallOptions) !delete_file_system.DeleteFileSystemOutput {
        return delete_file_system.execute(self, allocator, input, options);
    }

    /// Deletes the `FileSystemPolicy` for the specified file system.
    /// The default `FileSystemPolicy` goes into effect once the existing policy is
    /// deleted.
    /// For more information about the default file system policy, see [Using
    /// Resource-based Policies with
    /// EFS](https://docs.aws.amazon.com/efs/latest/ug/res-based-policies-efs.html).
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DeleteFileSystemPolicy` action.
    pub fn deleteFileSystemPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_file_system_policy.DeleteFileSystemPolicyInput, options: CallOptions) !delete_file_system_policy.DeleteFileSystemPolicyOutput {
        return delete_file_system_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified mount target.
    ///
    /// This operation forcibly breaks any mounts of the file system by using the
    /// mount target
    /// that is being deleted, which might disrupt instances or applications using
    /// those mounts. To
    /// avoid applications getting cut off abruptly, you might consider unmounting
    /// any mounts of the
    /// mount target, if feasible. The operation also deletes the associated network
    /// interface.
    /// Uncommitted writes might be lost, but breaking a mount target using this
    /// operation does not
    /// corrupt the file system itself. The file system you created remains. You can
    /// mount an
    /// EC2 instance in your VPC by using another mount target.
    ///
    /// This operation requires permissions for the following action on the file
    /// system:
    ///
    /// * `elasticfilesystem:DeleteMountTarget`
    ///
    /// The `DeleteMountTarget` call returns while the mount target state is still
    /// `deleting`. You can check the mount target deletion by calling the
    /// DescribeMountTargets operation, which returns a list of mount target
    /// descriptions for the given file system.
    ///
    /// The operation also requires permissions for the following Amazon EC2 action
    /// on the
    /// mount target's network interface:
    ///
    /// * `ec2:DeleteNetworkInterface`
    pub fn deleteMountTarget(self: *Self, allocator: std.mem.Allocator, input: delete_mount_target.DeleteMountTargetInput, options: CallOptions) !delete_mount_target.DeleteMountTargetOutput {
        return delete_mount_target.execute(self, allocator, input, options);
    }

    /// Deletes a replication configuration. Deleting a replication configuration
    /// ends the
    /// replication process. After a replication configuration is deleted, the
    /// destination file system
    /// becomes `Writeable` and its replication overwrite protection is re-enabled.
    /// For
    /// more information, see [Delete a replication
    /// configuration](https://docs.aws.amazon.com/efs/latest/ug/delete-replications.html).
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DeleteReplicationConfiguration` action.
    pub fn deleteReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_replication_configuration.DeleteReplicationConfigurationInput, options: CallOptions) !delete_replication_configuration.DeleteReplicationConfigurationOutput {
        return delete_replication_configuration.execute(self, allocator, input, options);
    }

    /// DEPRECATED - `DeleteTags` is deprecated and not maintained. To remove tags
    /// from EFS
    /// resources, use the API action.
    ///
    /// Deletes the specified tags from a file system. If the `DeleteTags` request
    /// includes a tag key that doesn't exist, Amazon EFS ignores it and doesn't
    /// cause an
    /// error. For more information about tags and related restrictions, see [Tag
    /// restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the
    /// *Billing and Cost Management User Guide*.
    ///
    /// This operation requires permissions for the `elasticfilesystem:DeleteTags`
    /// action.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: CallOptions) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Returns the description of a specific Amazon EFS access point if the
    /// `AccessPointId` is provided. If you provide an EFS
    /// `FileSystemId`, it returns descriptions of all access points for that file
    /// system. You can provide either an `AccessPointId` or a `FileSystemId` in
    /// the request, but not both.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DescribeAccessPoints` action.
    pub fn describeAccessPoints(self: *Self, allocator: std.mem.Allocator, input: describe_access_points.DescribeAccessPointsInput, options: CallOptions) !describe_access_points.DescribeAccessPointsOutput {
        return describe_access_points.execute(self, allocator, input, options);
    }

    /// Returns the account preferences settings for the Amazon Web Services account
    /// associated with the user making the request, in the current Amazon Web
    /// Services Region.
    pub fn describeAccountPreferences(self: *Self, allocator: std.mem.Allocator, input: describe_account_preferences.DescribeAccountPreferencesInput, options: CallOptions) !describe_account_preferences.DescribeAccountPreferencesOutput {
        return describe_account_preferences.execute(self, allocator, input, options);
    }

    /// Returns the backup policy for the specified EFS file system.
    pub fn describeBackupPolicy(self: *Self, allocator: std.mem.Allocator, input: describe_backup_policy.DescribeBackupPolicyInput, options: CallOptions) !describe_backup_policy.DescribeBackupPolicyOutput {
        return describe_backup_policy.execute(self, allocator, input, options);
    }

    /// Returns the `FileSystemPolicy` for the specified EFS file
    /// system.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DescribeFileSystemPolicy` action.
    pub fn describeFileSystemPolicy(self: *Self, allocator: std.mem.Allocator, input: describe_file_system_policy.DescribeFileSystemPolicyInput, options: CallOptions) !describe_file_system_policy.DescribeFileSystemPolicyOutput {
        return describe_file_system_policy.execute(self, allocator, input, options);
    }

    /// Returns the description of a specific Amazon EFS file system if either the
    /// file system
    /// `CreationToken` or the `FileSystemId` is provided. Otherwise, it
    /// returns descriptions of all file systems owned by the caller's Amazon Web
    /// Services account in the
    /// Amazon Web Services Region of the endpoint that you're calling.
    ///
    /// When retrieving all file system descriptions, you can optionally specify the
    /// `MaxItems` parameter to limit the number of descriptions in a response.
    /// This number is automatically set to 100. If more file system descriptions
    /// remain,
    /// Amazon EFS returns a `NextMarker`, an opaque token, in the response. In this
    /// case,
    /// you should send a subsequent request with the `Marker` request parameter set
    /// to the
    /// value of `NextMarker`.
    ///
    /// To retrieve a list of your file system descriptions, this operation is used
    /// in an
    /// iterative process, where `DescribeFileSystems` is called first without the
    /// `Marker` and then the operation continues to call it with the `Marker`
    /// parameter set to the value of the `NextMarker` from the previous response
    /// until the
    /// response has no `NextMarker`.
    ///
    /// The order of file systems returned in the response of one
    /// `DescribeFileSystems` call and the order of file systems returned across the
    /// responses of a multi-call iteration is unspecified.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DescribeFileSystems` action.
    pub fn describeFileSystems(self: *Self, allocator: std.mem.Allocator, input: describe_file_systems.DescribeFileSystemsInput, options: CallOptions) !describe_file_systems.DescribeFileSystemsOutput {
        return describe_file_systems.execute(self, allocator, input, options);
    }

    /// Returns the current `LifecycleConfiguration` object for the specified
    /// EFS file system. Lifecycle management uses the `LifecycleConfiguration`
    /// object to identify when to move files between storage classes. For a file
    /// system without a
    /// `LifecycleConfiguration` object, the call returns an empty array in the
    /// response.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DescribeLifecycleConfiguration` operation.
    pub fn describeLifecycleConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_lifecycle_configuration.DescribeLifecycleConfigurationInput, options: CallOptions) !describe_lifecycle_configuration.DescribeLifecycleConfigurationOutput {
        return describe_lifecycle_configuration.execute(self, allocator, input, options);
    }

    /// Returns the security groups currently in effect for a mount target. This
    /// operation
    /// requires that the network interface of the mount target has been created and
    /// the lifecycle
    /// state of the mount target is not `deleted`.
    ///
    /// This operation requires permissions for the following actions:
    ///
    /// * `elasticfilesystem:DescribeMountTargetSecurityGroups` action on the mount
    /// target's file system.
    ///
    /// * `ec2:DescribeNetworkInterfaceAttribute` action on the mount target's
    /// network interface.
    pub fn describeMountTargetSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: describe_mount_target_security_groups.DescribeMountTargetSecurityGroupsInput, options: CallOptions) !describe_mount_target_security_groups.DescribeMountTargetSecurityGroupsOutput {
        return describe_mount_target_security_groups.execute(self, allocator, input, options);
    }

    /// Returns the descriptions of all the current mount targets, or a specific
    /// mount target,
    /// for a file system. When requesting all of the current mount targets, the
    /// order of mount
    /// targets returned in the response is unspecified.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DescribeMountTargets` action, on either the file system
    /// ID
    /// that you specify in `FileSystemId`, or on the file system of the mount
    /// target that
    /// you specify in `MountTargetId`.
    pub fn describeMountTargets(self: *Self, allocator: std.mem.Allocator, input: describe_mount_targets.DescribeMountTargetsInput, options: CallOptions) !describe_mount_targets.DescribeMountTargetsOutput {
        return describe_mount_targets.execute(self, allocator, input, options);
    }

    /// Retrieves the replication configuration for a specific file system. If a
    /// file system is
    /// not specified, all of the replication configurations for the Amazon Web
    /// Services account in an
    /// Amazon Web Services Region are retrieved.
    pub fn describeReplicationConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_replication_configurations.DescribeReplicationConfigurationsInput, options: CallOptions) !describe_replication_configurations.DescribeReplicationConfigurationsOutput {
        return describe_replication_configurations.execute(self, allocator, input, options);
    }

    /// DEPRECATED - The `DescribeTags` action is deprecated and not maintained. To
    /// view
    /// tags associated with EFS resources, use the `ListTagsForResource` API
    /// action.
    ///
    /// Returns the tags associated with a file system. The order of tags returned
    /// in the
    /// response of one `DescribeTags` call and the order of tags returned across
    /// the
    /// responses of a multiple-call iteration (when using pagination) is
    /// unspecified.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DescribeTags` action.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: CallOptions) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Lists all tags for a top-level EFS resource. You must provide the ID of the
    /// resource that you want to retrieve the tags for.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:DescribeAccessPoints` action.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Modifies the set of security groups in effect for a mount target.
    ///
    /// When you create a mount target, Amazon EFS also creates a new network
    /// interface. For
    /// more information, see CreateMountTarget. This operation replaces the
    /// security groups in effect for the
    /// network interface associated with a mount target, with the `SecurityGroups`
    /// provided in the request. This operation requires that the network interface
    /// of the mount
    /// target has been created and the lifecycle state of the mount target is not
    /// `deleted`.
    ///
    /// The operation requires permissions for the following actions:
    ///
    /// * `elasticfilesystem:ModifyMountTargetSecurityGroups` action on the mount
    /// target's file system.
    ///
    /// * `ec2:ModifyNetworkInterfaceAttribute` action on the mount target's network
    /// interface.
    pub fn modifyMountTargetSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: modify_mount_target_security_groups.ModifyMountTargetSecurityGroupsInput, options: CallOptions) !modify_mount_target_security_groups.ModifyMountTargetSecurityGroupsOutput {
        return modify_mount_target_security_groups.execute(self, allocator, input, options);
    }

    /// Use this operation to set the account preference in the current Amazon Web
    /// Services Region
    /// to use long 17 character (63 bit) or short 8 character (32 bit) resource IDs
    /// for new
    /// EFS file system and mount target resources. All existing resource IDs are
    /// not
    /// affected by any changes you make. You can set the ID preference during the
    /// opt-in period as
    /// EFS transitions to long resource IDs. For more information, see [Managing
    /// Amazon EFS resource
    /// IDs](https://docs.aws.amazon.com/efs/latest/ug/manage-efs-resource-ids.html).
    ///
    /// Starting in October, 2021, you will receive an error if you try to set the
    /// account preference
    /// to use the short 8 character format resource ID. Contact Amazon Web Services
    /// support if you
    /// receive an error and must use short IDs for file system and mount target
    /// resources.
    pub fn putAccountPreferences(self: *Self, allocator: std.mem.Allocator, input: put_account_preferences.PutAccountPreferencesInput, options: CallOptions) !put_account_preferences.PutAccountPreferencesOutput {
        return put_account_preferences.execute(self, allocator, input, options);
    }

    /// Updates the file system's backup policy. Use this action to start or stop
    /// automatic backups of the file system.
    pub fn putBackupPolicy(self: *Self, allocator: std.mem.Allocator, input: put_backup_policy.PutBackupPolicyInput, options: CallOptions) !put_backup_policy.PutBackupPolicyOutput {
        return put_backup_policy.execute(self, allocator, input, options);
    }

    /// Applies an Amazon EFS
    /// `FileSystemPolicy` to an Amazon EFS file system. A file system policy is an
    /// IAM resource-based policy and can contain multiple policy statements. A file
    /// system always has
    /// exactly one file system policy, which can be the default policy or an
    /// explicit policy set or
    /// updated using this API operation. EFS file system policies have a 20,000
    /// character
    /// limit. When an explicit policy is set, it overrides the default policy. For
    /// more information
    /// about the default file system policy, see [
    /// Default EFS file system
    /// policy](https://docs.aws.amazon.com/efs/latest/ug/iam-access-control-nfs-efs.html#default-filesystempolicy).
    ///
    /// EFS file system policies have a 20,000 character limit.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:PutFileSystemPolicy` action.
    pub fn putFileSystemPolicy(self: *Self, allocator: std.mem.Allocator, input: put_file_system_policy.PutFileSystemPolicyInput, options: CallOptions) !put_file_system_policy.PutFileSystemPolicyOutput {
        return put_file_system_policy.execute(self, allocator, input, options);
    }

    /// Use this action to manage storage for your file system. A
    /// `LifecycleConfiguration` consists of one or more `LifecyclePolicy`
    /// objects that define the following:
    ///
    /// * **
    /// `TransitionToIA`
    /// ** –
    /// When to move files in the file system from primary storage (Standard storage
    /// class) into the Infrequent Access
    /// (IA) storage.
    ///
    /// * **
    /// `TransitionToArchive`
    /// ** –
    /// When to move files in the file system from their current storage class
    /// (either IA or Standard storage) into the
    /// Archive storage.
    ///
    /// File systems cannot transition into Archive storage before transitioning
    /// into IA storage. Therefore,
    /// TransitionToArchive must either not be set or must be later than
    /// TransitionToIA.
    ///
    /// The Archive storage class is available only for file systems that use the
    /// Elastic throughput mode
    /// and the General Purpose performance mode.
    ///
    /// * **
    /// `TransitionToPrimaryStorageClass`
    /// ** –
    /// Whether to move files in the file system back to primary storage (Standard
    /// storage class) after they are accessed in IA
    /// or Archive storage.
    ///
    /// For more information, see [ Managing file system
    /// storage](https://docs.aws.amazon.com/efs/latest/ug/lifecycle-management-efs.html).
    ///
    /// Each Amazon EFS file system supports one lifecycle configuration, which
    /// applies to
    /// all files in the file system. If a `LifecycleConfiguration` object already
    /// exists
    /// for the specified file system, a `PutLifecycleConfiguration` call modifies
    /// the
    /// existing configuration. A `PutLifecycleConfiguration` call with an empty
    /// `LifecyclePolicies` array in the request body deletes any existing
    /// `LifecycleConfiguration`. In the request, specify the following:
    ///
    /// * The ID for the file system for which you are enabling, disabling, or
    ///   modifying
    /// lifecycle management.
    ///
    /// * A `LifecyclePolicies` array of `LifecyclePolicy` objects that
    /// define when to move files to IA storage, to Archive storage,
    /// and back to primary storage.
    ///
    /// Amazon EFS requires that each `LifecyclePolicy`
    /// object have only have a single transition, so the `LifecyclePolicies` array
    /// needs to be structured with separate
    /// `LifecyclePolicy` objects. See the example requests in the following section
    /// for more information.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:PutLifecycleConfiguration` operation.
    ///
    /// To apply a `LifecycleConfiguration` object to an encrypted file system, you
    /// need the same Key Management Service permissions as when you created the
    /// encrypted file system.
    pub fn putLifecycleConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_lifecycle_configuration.PutLifecycleConfigurationInput, options: CallOptions) !put_lifecycle_configuration.PutLifecycleConfigurationOutput {
        return put_lifecycle_configuration.execute(self, allocator, input, options);
    }

    /// Creates a tag for an EFS resource. You can create tags for EFS file
    /// systems and access points using this API operation.
    ///
    /// This operation requires permissions for the `elasticfilesystem:TagResource`
    /// action.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an EFS resource. You can remove tags from EFS file
    /// systems and access points using this API operation.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:UntagResource` action.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the throughput mode or the amount of provisioned throughput of an
    /// existing file
    /// system.
    pub fn updateFileSystem(self: *Self, allocator: std.mem.Allocator, input: update_file_system.UpdateFileSystemInput, options: CallOptions) !update_file_system.UpdateFileSystemOutput {
        return update_file_system.execute(self, allocator, input, options);
    }

    /// Updates protection on the file system.
    ///
    /// This operation requires permissions for the
    /// `elasticfilesystem:UpdateFileSystemProtection` action.
    pub fn updateFileSystemProtection(self: *Self, allocator: std.mem.Allocator, input: update_file_system_protection.UpdateFileSystemProtectionInput, options: CallOptions) !update_file_system_protection.UpdateFileSystemProtectionOutput {
        return update_file_system_protection.execute(self, allocator, input, options);
    }

    pub fn describeAccessPointsPaginator(self: *Self, params: describe_access_points.DescribeAccessPointsInput) paginator.DescribeAccessPointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeFileSystemsPaginator(self: *Self, params: describe_file_systems.DescribeFileSystemsInput) paginator.DescribeFileSystemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeMountTargetsPaginator(self: *Self, params: describe_mount_targets.DescribeMountTargetsInput) paginator.DescribeMountTargetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeReplicationConfigurationsPaginator(self: *Self, params: describe_replication_configurations.DescribeReplicationConfigurationsInput) paginator.DescribeReplicationConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeTagsPaginator(self: *Self, params: describe_tags.DescribeTagsInput) paginator.DescribeTagsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
