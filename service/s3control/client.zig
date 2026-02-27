const aws = @import("aws");
const std = @import("std");

const associate_access_grants_identity_center = @import("associate_access_grants_identity_center.zig");
const create_access_grant = @import("create_access_grant.zig");
const create_access_grants_instance = @import("create_access_grants_instance.zig");
const create_access_grants_location = @import("create_access_grants_location.zig");
const create_access_point = @import("create_access_point.zig");
const create_access_point_for_object_lambda = @import("create_access_point_for_object_lambda.zig");
const create_bucket = @import("create_bucket.zig");
const create_job = @import("create_job.zig");
const create_multi_region_access_point = @import("create_multi_region_access_point.zig");
const create_storage_lens_group = @import("create_storage_lens_group.zig");
const delete_access_grant = @import("delete_access_grant.zig");
const delete_access_grants_instance = @import("delete_access_grants_instance.zig");
const delete_access_grants_instance_resource_policy = @import("delete_access_grants_instance_resource_policy.zig");
const delete_access_grants_location = @import("delete_access_grants_location.zig");
const delete_access_point = @import("delete_access_point.zig");
const delete_access_point_for_object_lambda = @import("delete_access_point_for_object_lambda.zig");
const delete_access_point_policy = @import("delete_access_point_policy.zig");
const delete_access_point_policy_for_object_lambda = @import("delete_access_point_policy_for_object_lambda.zig");
const delete_access_point_scope = @import("delete_access_point_scope.zig");
const delete_bucket = @import("delete_bucket.zig");
const delete_bucket_lifecycle_configuration = @import("delete_bucket_lifecycle_configuration.zig");
const delete_bucket_policy = @import("delete_bucket_policy.zig");
const delete_bucket_replication = @import("delete_bucket_replication.zig");
const delete_bucket_tagging = @import("delete_bucket_tagging.zig");
const delete_job_tagging = @import("delete_job_tagging.zig");
const delete_multi_region_access_point = @import("delete_multi_region_access_point.zig");
const delete_public_access_block = @import("delete_public_access_block.zig");
const delete_storage_lens_configuration = @import("delete_storage_lens_configuration.zig");
const delete_storage_lens_configuration_tagging = @import("delete_storage_lens_configuration_tagging.zig");
const delete_storage_lens_group = @import("delete_storage_lens_group.zig");
const describe_job = @import("describe_job.zig");
const describe_multi_region_access_point_operation = @import("describe_multi_region_access_point_operation.zig");
const dissociate_access_grants_identity_center = @import("dissociate_access_grants_identity_center.zig");
const get_access_grant = @import("get_access_grant.zig");
const get_access_grants_instance = @import("get_access_grants_instance.zig");
const get_access_grants_instance_for_prefix = @import("get_access_grants_instance_for_prefix.zig");
const get_access_grants_instance_resource_policy = @import("get_access_grants_instance_resource_policy.zig");
const get_access_grants_location = @import("get_access_grants_location.zig");
const get_access_point = @import("get_access_point.zig");
const get_access_point_configuration_for_object_lambda = @import("get_access_point_configuration_for_object_lambda.zig");
const get_access_point_for_object_lambda = @import("get_access_point_for_object_lambda.zig");
const get_access_point_policy = @import("get_access_point_policy.zig");
const get_access_point_policy_for_object_lambda = @import("get_access_point_policy_for_object_lambda.zig");
const get_access_point_policy_status = @import("get_access_point_policy_status.zig");
const get_access_point_policy_status_for_object_lambda = @import("get_access_point_policy_status_for_object_lambda.zig");
const get_access_point_scope = @import("get_access_point_scope.zig");
const get_bucket = @import("get_bucket.zig");
const get_bucket_lifecycle_configuration = @import("get_bucket_lifecycle_configuration.zig");
const get_bucket_policy = @import("get_bucket_policy.zig");
const get_bucket_replication = @import("get_bucket_replication.zig");
const get_bucket_tagging = @import("get_bucket_tagging.zig");
const get_bucket_versioning = @import("get_bucket_versioning.zig");
const get_data_access = @import("get_data_access.zig");
const get_job_tagging = @import("get_job_tagging.zig");
const get_multi_region_access_point = @import("get_multi_region_access_point.zig");
const get_multi_region_access_point_policy = @import("get_multi_region_access_point_policy.zig");
const get_multi_region_access_point_policy_status = @import("get_multi_region_access_point_policy_status.zig");
const get_multi_region_access_point_routes = @import("get_multi_region_access_point_routes.zig");
const get_public_access_block = @import("get_public_access_block.zig");
const get_storage_lens_configuration = @import("get_storage_lens_configuration.zig");
const get_storage_lens_configuration_tagging = @import("get_storage_lens_configuration_tagging.zig");
const get_storage_lens_group = @import("get_storage_lens_group.zig");
const list_access_grants = @import("list_access_grants.zig");
const list_access_grants_instances = @import("list_access_grants_instances.zig");
const list_access_grants_locations = @import("list_access_grants_locations.zig");
const list_access_points = @import("list_access_points.zig");
const list_access_points_for_directory_buckets = @import("list_access_points_for_directory_buckets.zig");
const list_access_points_for_object_lambda = @import("list_access_points_for_object_lambda.zig");
const list_caller_access_grants = @import("list_caller_access_grants.zig");
const list_jobs = @import("list_jobs.zig");
const list_multi_region_access_points = @import("list_multi_region_access_points.zig");
const list_regional_buckets = @import("list_regional_buckets.zig");
const list_storage_lens_configurations = @import("list_storage_lens_configurations.zig");
const list_storage_lens_groups = @import("list_storage_lens_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_access_grants_instance_resource_policy = @import("put_access_grants_instance_resource_policy.zig");
const put_access_point_configuration_for_object_lambda = @import("put_access_point_configuration_for_object_lambda.zig");
const put_access_point_policy = @import("put_access_point_policy.zig");
const put_access_point_policy_for_object_lambda = @import("put_access_point_policy_for_object_lambda.zig");
const put_access_point_scope = @import("put_access_point_scope.zig");
const put_bucket_lifecycle_configuration = @import("put_bucket_lifecycle_configuration.zig");
const put_bucket_policy = @import("put_bucket_policy.zig");
const put_bucket_replication = @import("put_bucket_replication.zig");
const put_bucket_tagging = @import("put_bucket_tagging.zig");
const put_bucket_versioning = @import("put_bucket_versioning.zig");
const put_job_tagging = @import("put_job_tagging.zig");
const put_multi_region_access_point_policy = @import("put_multi_region_access_point_policy.zig");
const put_public_access_block = @import("put_public_access_block.zig");
const put_storage_lens_configuration = @import("put_storage_lens_configuration.zig");
const put_storage_lens_configuration_tagging = @import("put_storage_lens_configuration_tagging.zig");
const submit_multi_region_access_point_routes = @import("submit_multi_region_access_point_routes.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_access_grants_location = @import("update_access_grants_location.zig");
const update_job_priority = @import("update_job_priority.zig");
const update_job_status = @import("update_job_status.zig");
const update_storage_lens_group = @import("update_storage_lens_group.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "S3 Control";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associate your S3 Access Grants instance with an Amazon Web Services IAM
    /// Identity Center instance. Use this action if you want to create access
    /// grants for users or groups from your corporate identity directory. First,
    /// you must add your corporate identity directory to Amazon Web Services IAM
    /// Identity Center. Then, you can associate this IAM Identity Center instance
    /// with your S3 Access Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:AssociateAccessGrantsIdentityCenter` permission to use
    /// this operation.
    ///
    /// **Additional Permissions**
    ///
    /// You must also have the following permissions: `sso:CreateApplication`,
    /// `sso:PutApplicationGrant`, and `sso:PutApplicationAuthenticationMethod`.
    pub fn associateAccessGrantsIdentityCenter(self: *Self, allocator: std.mem.Allocator, input: associate_access_grants_identity_center.AssociateAccessGrantsIdentityCenterInput, options: associate_access_grants_identity_center.Options) !associate_access_grants_identity_center.AssociateAccessGrantsIdentityCenterOutput {
        return associate_access_grants_identity_center.execute(self, allocator, input, options);
    }

    /// Creates an access grant that gives a grantee access to your S3 data. The
    /// grantee can be an IAM user or role or a directory user, or group. Before you
    /// can create a grant, you must have an S3 Access Grants instance in the same
    /// Region as the S3 data. You can create an S3 Access Grants instance using the
    /// [CreateAccessGrantsInstance](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessGrantsInstance.html). You must also have registered at least one S3 data location in your S3 Access Grants instance using [CreateAccessGrantsLocation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessGrantsLocation.html).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:CreateAccessGrant` permission to use this operation.
    ///
    /// **Additional Permissions**
    ///
    /// For any directory identity - `sso:DescribeInstance` and
    /// `sso:DescribeApplication`
    ///
    /// For directory users - `identitystore:DescribeUser`
    ///
    /// For directory groups - `identitystore:DescribeGroup`
    pub fn createAccessGrant(self: *Self, allocator: std.mem.Allocator, input: create_access_grant.CreateAccessGrantInput, options: create_access_grant.Options) !create_access_grant.CreateAccessGrantOutput {
        return create_access_grant.execute(self, allocator, input, options);
    }

    /// Creates an S3 Access Grants instance, which serves as a logical grouping for
    /// access grants. You can create one S3 Access Grants instance per Region per
    /// account.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:CreateAccessGrantsInstance` permission to use this
    /// operation.
    ///
    /// **Additional Permissions**
    ///
    /// To associate an IAM Identity Center instance with your S3 Access Grants
    /// instance, you must also have the `sso:DescribeInstance`,
    /// `sso:CreateApplication`, `sso:PutApplicationGrant`, and
    /// `sso:PutApplicationAuthenticationMethod` permissions.
    pub fn createAccessGrantsInstance(self: *Self, allocator: std.mem.Allocator, input: create_access_grants_instance.CreateAccessGrantsInstanceInput, options: create_access_grants_instance.Options) !create_access_grants_instance.CreateAccessGrantsInstanceOutput {
        return create_access_grants_instance.execute(self, allocator, input, options);
    }

    /// The S3 data location that you would like to register in your S3 Access
    /// Grants instance. Your S3 data must be in the same Region as your S3 Access
    /// Grants instance. The location can be one of the following:
    ///
    /// * The default S3 location `s3://`
    ///
    /// * A bucket - `S3://`
    ///
    /// * A bucket and prefix - `S3:///`
    ///
    /// When you register a location, you must include the IAM role that has
    /// permission to manage the S3 location that you are registering. Give S3
    /// Access Grants permission to assume this role [using a
    /// policy](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-grants-location.html). S3 Access Grants assumes this role to manage access to the location and to vend temporary credentials to grantees or client applications.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:CreateAccessGrantsLocation` permission to use this
    /// operation.
    ///
    /// **Additional Permissions**
    ///
    /// You must also have the following permission for the specified IAM role:
    /// `iam:PassRole`
    pub fn createAccessGrantsLocation(self: *Self, allocator: std.mem.Allocator, input: create_access_grants_location.CreateAccessGrantsLocationInput, options: create_access_grants_location.Options) !create_access_grants_location.CreateAccessGrantsLocationOutput {
        return create_access_grants_location.execute(self, allocator, input, options);
    }

    /// Creates an access point and associates it to a specified bucket. For more
    /// information, see
    /// [Managing
    /// access to shared datasets with access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points.html) or [Managing access to
    /// shared datasets in directory buckets with access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-directory-buckets.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// To create an access point and attach it to a volume on an Amazon FSx file
    /// system, see
    /// [CreateAndAttachS3AccessPoint](https://docs.aws.amazon.com/fsx/latest/APIReference/API_CreateAndAttachS3AccessPoint.html) in the *Amazon FSx API
    /// Reference*.
    ///
    /// S3 on Outposts only supports VPC-style access points.
    ///
    /// For more information, see [ Accessing Amazon S3 on Outposts using
    /// virtual private cloud (VPC) only access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPoint.html#API_control_CreateAccessPoint_Examples) section.
    ///
    /// The following actions are related to `CreateAccessPoint`:
    ///
    /// *
    ///   [GetAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPoint.html)
    ///
    /// *
    ///   [DeleteAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPoint.html)
    ///
    /// *
    ///   [ListAccessPoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPoints.html)
    ///
    /// *
    ///   [ListAccessPointsForDirectoryBuckets](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPointsForDirectoryBuckets.html)
    pub fn createAccessPoint(self: *Self, allocator: std.mem.Allocator, input: create_access_point.CreateAccessPointInput, options: create_access_point.Options) !create_access_point.CreateAccessPointOutput {
        return create_access_point.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Creates an Object Lambda Access Point. For more information, see
    /// [Transforming objects with
    /// Object Lambda Access
    /// Points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/transforming-objects.html) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to
    /// `CreateAccessPointForObjectLambda`:
    ///
    /// *
    ///   [DeleteAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [GetAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [ListAccessPointsForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPointsForObjectLambda.html)
    pub fn createAccessPointForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: create_access_point_for_object_lambda.CreateAccessPointForObjectLambdaInput, options: create_access_point_for_object_lambda.Options) !create_access_point_for_object_lambda.CreateAccessPointForObjectLambdaOutput {
        return create_access_point_for_object_lambda.execute(self, allocator, input, options);
    }

    /// This action creates an Amazon S3 on Outposts bucket. To create an S3 bucket,
    /// see [Create
    /// Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html) in the *Amazon S3 API Reference*.
    ///
    /// Creates a new Outposts bucket. By creating the bucket, you become the bucket
    /// owner. To
    /// create an Outposts bucket, you must have S3 on Outposts. For more
    /// information, see [Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in *Amazon S3 User Guide*.
    ///
    /// Not every string is an acceptable bucket name. For information on bucket
    /// naming
    /// restrictions, see [Working with
    /// Amazon S3
    /// Buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/BucketRestrictions.html#bucketnamingrules).
    ///
    /// S3 on Outposts buckets support:
    ///
    /// * Tags
    ///
    /// * LifecycleConfigurations for deleting expired objects
    ///
    /// For a complete list of restrictions and Amazon S3 feature limitations on S3
    /// on Outposts, see
    /// [
    /// Amazon S3 on Outposts Restrictions and
    /// Limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OnOutpostsRestrictionsLimitations.html).
    ///
    /// For an example of the request syntax for Amazon S3 on Outposts that uses the
    /// S3 on Outposts
    /// endpoint hostname prefix and `x-amz-outpost-id` in your API request, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateBucket.html#API_control_CreateBucket_Examples) section.
    ///
    /// The following actions are related to `CreateBucket` for
    /// Amazon S3 on Outposts:
    ///
    /// *
    ///   [PutObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
    ///
    /// *
    ///   [GetBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucket.html)
    ///
    /// *
    ///   [DeleteBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucket.html)
    ///
    /// *
    ///   [CreateAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPoint.html)
    ///
    /// *
    ///   [PutAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutAccessPointPolicy.html)
    pub fn createBucket(self: *Self, allocator: std.mem.Allocator, input: create_bucket.CreateBucketInput, options: create_bucket.Options) !create_bucket.CreateBucketOutput {
        return create_bucket.execute(self, allocator, input, options);
    }

    /// This operation creates an S3 Batch Operations job.
    ///
    /// You can use S3 Batch Operations to perform large-scale batch actions on
    /// Amazon S3 objects.
    /// Batch Operations can run a single action on lists of Amazon S3 objects that
    /// you specify. For more
    /// information, see [S3 Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/batch-ops.html) in the *Amazon S3 User Guide*.
    ///
    /// **Permissions**
    ///
    /// For information about permissions required to use the Batch Operations, see
    /// [Granting permissions for S3 Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/batch-ops-iam-role-policies.html) in the *Amazon S3
    /// User Guide*.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [DescribeJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeJob.html)
    ///
    /// *
    ///   [ListJobs](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListJobs.html)
    ///
    /// *
    ///   [UpdateJobPriority](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobPriority.html)
    ///
    /// *
    ///   [UpdateJobStatus](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobStatus.html)
    ///
    /// *
    ///   [JobOperation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_JobOperation.html)
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: create_job.Options) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Creates a Multi-Region Access Point and associates it with the specified
    /// buckets. For more information
    /// about creating Multi-Region Access Points, see [Creating Multi-Region Access
    /// Points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CreatingMultiRegionAccessPoints.html) in the *Amazon S3 User Guide*.
    ///
    /// This action will always be routed to the US West (Oregon) Region. For more
    /// information
    /// about the restrictions around working with Multi-Region Access Points, see
    /// [Multi-Region Access Point
    /// restrictions and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiRegionAccessPointRestrictions.html) in the *Amazon S3 User Guide*.
    ///
    /// This request is asynchronous, meaning that you might receive a response
    /// before the
    /// command has completed. When this request provides a response, it provides a
    /// token that you
    /// can use to monitor the status of the request with
    /// `DescribeMultiRegionAccessPointOperation`.
    ///
    /// The following actions are related to `CreateMultiRegionAccessPoint`:
    ///
    /// *
    ///   [DeleteMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [DescribeMultiRegionAccessPointOperation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeMultiRegionAccessPointOperation.html)
    ///
    /// *
    ///   [GetMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [ListMultiRegionAccessPoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListMultiRegionAccessPoints.html)
    pub fn createMultiRegionAccessPoint(self: *Self, allocator: std.mem.Allocator, input: create_multi_region_access_point.CreateMultiRegionAccessPointInput, options: create_multi_region_access_point.Options) !create_multi_region_access_point.CreateMultiRegionAccessPointOutput {
        return create_multi_region_access_point.execute(self, allocator, input, options);
    }

    /// Creates a new S3 Storage Lens group and associates it with the specified
    /// Amazon Web Services account ID. An
    /// S3 Storage Lens group is a custom grouping of objects based on prefix,
    /// suffix, object tags,
    /// object size, object age, or a combination of these filters. For each Storage
    /// Lens group
    /// that you’ve created, you can also optionally add Amazon Web Services
    /// resource tags. For more information
    /// about S3 Storage Lens groups, see [Working with S3 Storage Lens
    /// groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-lens-groups-overview.html).
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3:CreateStorageLensGroup` action. If you’re trying to create a Storage
    /// Lens
    /// group with Amazon Web Services resource tags, you must also have permission
    /// to perform the
    /// `s3:TagResource` action. For more information about the required Storage
    /// Lens
    /// Groups permissions, see [Setting account permissions to use S3 Storage Lens
    /// groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_iam_permissions.html#storage_lens_groups_permissions).
    ///
    /// For information about Storage Lens groups errors, see [List of Amazon S3
    /// Storage
    /// Lens error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3LensErrorCodeList).
    pub fn createStorageLensGroup(self: *Self, allocator: std.mem.Allocator, input: create_storage_lens_group.CreateStorageLensGroupInput, options: create_storage_lens_group.Options) !create_storage_lens_group.CreateStorageLensGroupOutput {
        return create_storage_lens_group.execute(self, allocator, input, options);
    }

    /// Deletes the access grant from the S3 Access Grants instance. You cannot undo
    /// an access grant deletion and the grantee will no longer have access to the
    /// S3 data.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:DeleteAccessGrant` permission to use this operation.
    pub fn deleteAccessGrant(self: *Self, allocator: std.mem.Allocator, input: delete_access_grant.DeleteAccessGrantInput, options: delete_access_grant.Options) !delete_access_grant.DeleteAccessGrantOutput {
        return delete_access_grant.execute(self, allocator, input, options);
    }

    /// Deletes your S3 Access Grants instance. You must first delete the access
    /// grants and locations before S3 Access Grants can delete the instance. See
    /// [DeleteAccessGrant](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessGrant.html) and [DeleteAccessGrantsLocation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessGrantsLocation.html). If you have associated an IAM Identity Center instance with your S3 Access Grants instance, you must first dissassociate the Identity Center instance from the S3 Access Grants instance before you can delete the S3 Access Grants instance. See [AssociateAccessGrantsIdentityCenter](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_AssociateAccessGrantsIdentityCenter.html) and [DissociateAccessGrantsIdentityCenter](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DissociateAccessGrantsIdentityCenter.html).
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:DeleteAccessGrantsInstance` permission to use this
    /// operation.
    pub fn deleteAccessGrantsInstance(self: *Self, allocator: std.mem.Allocator, input: delete_access_grants_instance.DeleteAccessGrantsInstanceInput, options: delete_access_grants_instance.Options) !delete_access_grants_instance.DeleteAccessGrantsInstanceOutput {
        return delete_access_grants_instance.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy of the S3 Access Grants instance. The resource
    /// policy is used to manage cross-account access to your S3 Access Grants
    /// instance. By deleting the resource policy, you delete any cross-account
    /// permissions to your S3 Access Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:DeleteAccessGrantsInstanceResourcePolicy` permission
    /// to use this operation.
    pub fn deleteAccessGrantsInstanceResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_access_grants_instance_resource_policy.DeleteAccessGrantsInstanceResourcePolicyInput, options: delete_access_grants_instance_resource_policy.Options) !delete_access_grants_instance_resource_policy.DeleteAccessGrantsInstanceResourcePolicyOutput {
        return delete_access_grants_instance_resource_policy.execute(self, allocator, input, options);
    }

    /// Deregisters a location from your S3 Access Grants instance. You can only
    /// delete a location registration from an S3 Access Grants instance if there
    /// are no grants associated with this location. See [Delete a
    /// grant](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessGrant.html) for information on how to delete grants. You need to have at least one registered location in your S3 Access Grants instance in order to create access grants.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:DeleteAccessGrantsLocation` permission to use this
    /// operation.
    pub fn deleteAccessGrantsLocation(self: *Self, allocator: std.mem.Allocator, input: delete_access_grants_location.DeleteAccessGrantsLocationInput, options: delete_access_grants_location.Options) !delete_access_grants_location.DeleteAccessGrantsLocationOutput {
        return delete_access_grants_location.execute(self, allocator, input, options);
    }

    /// Deletes the specified access point.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPoint.html#API_control_DeleteAccessPoint_Examples) section.
    ///
    /// The following actions are related to `DeleteAccessPoint`:
    ///
    /// *
    ///   [CreateAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPoint.html)
    ///
    /// *
    ///   [GetAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPoint.html)
    ///
    /// *
    ///   [ListAccessPoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPoints.html)
    pub fn deleteAccessPoint(self: *Self, allocator: std.mem.Allocator, input: delete_access_point.DeleteAccessPointInput, options: delete_access_point.Options) !delete_access_point.DeleteAccessPointOutput {
        return delete_access_point.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Deletes the specified Object Lambda Access Point.
    ///
    /// The following actions are related to
    /// `DeleteAccessPointForObjectLambda`:
    ///
    /// *
    ///   [CreateAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [GetAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [ListAccessPointsForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPointsForObjectLambda.html)
    pub fn deleteAccessPointForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: delete_access_point_for_object_lambda.DeleteAccessPointForObjectLambdaInput, options: delete_access_point_for_object_lambda.Options) !delete_access_point_for_object_lambda.DeleteAccessPointForObjectLambdaOutput {
        return delete_access_point_for_object_lambda.execute(self, allocator, input, options);
    }

    /// Deletes the access point policy for the specified access point.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointPolicy.html#API_control_DeleteAccessPointPolicy_Examples) section.
    ///
    /// The following actions are related to `DeleteAccessPointPolicy`:
    ///
    /// *
    ///   [PutAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutAccessPointPolicy.html)
    ///
    /// *
    ///   [GetAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointPolicy.html)
    pub fn deleteAccessPointPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_access_point_policy.DeleteAccessPointPolicyInput, options: delete_access_point_policy.Options) !delete_access_point_policy.DeleteAccessPointPolicyOutput {
        return delete_access_point_policy.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Removes the resource policy for an Object Lambda Access Point.
    ///
    /// The following actions are related to
    /// `DeleteAccessPointPolicyForObjectLambda`:
    ///
    /// *
    ///   [GetAccessPointPolicyForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointPolicyForObjectLambda.html)
    ///
    /// *
    ///   [PutAccessPointPolicyForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutAccessPointPolicyForObjectLambda.html)
    pub fn deleteAccessPointPolicyForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: delete_access_point_policy_for_object_lambda.DeleteAccessPointPolicyForObjectLambdaInput, options: delete_access_point_policy_for_object_lambda.Options) !delete_access_point_policy_for_object_lambda.DeleteAccessPointPolicyForObjectLambdaOutput {
        return delete_access_point_policy_for_object_lambda.execute(self, allocator, input, options);
    }

    /// Deletes an existing access point scope for a directory bucket.
    ///
    /// When you delete the scope of an access point, all prefixes and permissions
    /// are deleted.
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3express:DeleteAccessPointScope` action.
    ///
    /// For information about REST API errors, see [REST error
    /// responses](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#RESTErrorResponses).
    pub fn deleteAccessPointScope(self: *Self, allocator: std.mem.Allocator, input: delete_access_point_scope.DeleteAccessPointScopeInput, options: delete_access_point_scope.Options) !delete_access_point_scope.DeleteAccessPointScopeOutput {
        return delete_access_point_scope.execute(self, allocator, input, options);
    }

    /// This action deletes an Amazon S3 on Outposts bucket. To delete an S3 bucket,
    /// see
    /// [DeleteBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html) in the *Amazon S3 API Reference*.
    ///
    /// Deletes the Amazon S3 on Outposts bucket. All objects (including all object
    /// versions and
    /// delete markers) in the bucket must be deleted before the bucket itself can
    /// be deleted. For
    /// more information, see [Using Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in
    /// *Amazon S3 User Guide*.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucket.html#API_control_DeleteBucket_Examples) section.
    ///
    /// **Related Resources**
    ///
    /// *
    ///   [CreateBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateBucket.html)
    ///
    /// *
    ///   [GetBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucket.html)
    ///
    /// *
    ///   [DeleteObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html)
    pub fn deleteBucket(self: *Self, allocator: std.mem.Allocator, input: delete_bucket.DeleteBucketInput, options: delete_bucket.Options) !delete_bucket.DeleteBucketOutput {
        return delete_bucket.execute(self, allocator, input, options);
    }

    /// This action deletes an Amazon S3 on Outposts bucket's lifecycle
    /// configuration. To delete
    /// an S3 bucket's lifecycle configuration, see
    /// [DeleteBucketLifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketLifecycle.html) in the *Amazon S3 API Reference*.
    ///
    /// Deletes the lifecycle configuration from the specified Outposts bucket.
    /// Amazon S3 on Outposts removes all the lifecycle configuration rules in the
    /// lifecycle subresource
    /// associated with the bucket. Your objects never expire, and Amazon S3 on
    /// Outposts no longer
    /// automatically deletes any objects on the basis of rules contained in the
    /// deleted lifecycle
    /// configuration. For more information, see [Using Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in
    /// *Amazon S3 User Guide*.
    ///
    /// To use this operation, you must have permission to perform the
    /// `s3-outposts:PutLifecycleConfiguration` action. By default, the bucket owner
    /// has this permission and the Outposts bucket owner can grant this permission
    /// to
    /// others.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketLifecycleConfiguration.html#API_control_DeleteBucketLifecycleConfiguration_Examples) section.
    ///
    /// For more information about object expiration, see [Elements to Describe
    /// Lifecycle
    /// Actions](https://docs.aws.amazon.com/AmazonS3/latest/dev/intro-lifecycle-rules.html#intro-lifecycle-rules-actions).
    ///
    /// Related actions include:
    ///
    /// *
    ///   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketLifecycleConfiguration.html)
    ///
    /// *
    ///   [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketLifecycleConfiguration.html)
    pub fn deleteBucketLifecycleConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_bucket_lifecycle_configuration.DeleteBucketLifecycleConfigurationInput, options: delete_bucket_lifecycle_configuration.Options) !delete_bucket_lifecycle_configuration.DeleteBucketLifecycleConfigurationOutput {
        return delete_bucket_lifecycle_configuration.execute(self, allocator, input, options);
    }

    /// This action deletes an Amazon S3 on Outposts bucket policy. To delete an S3
    /// bucket policy,
    /// see
    /// [DeleteBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketPolicy.html) in the *Amazon S3 API Reference*.
    ///
    /// This implementation of the DELETE action uses the policy subresource to
    /// delete the
    /// policy of a specified Amazon S3 on Outposts bucket. If you are using an
    /// identity other than the
    /// root user of the Amazon Web Services account that owns the bucket, the
    /// calling identity must have the
    /// `s3-outposts:DeleteBucketPolicy` permissions on the specified Outposts
    /// bucket
    /// and belong to the bucket owner's account to use this action. For more
    /// information, see
    /// [Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in *Amazon S3 User Guide*.
    ///
    /// If you don't have `DeleteBucketPolicy` permissions, Amazon S3 returns a `403
    /// Access Denied` error. If you have the correct permissions, but you're not
    /// using an
    /// identity that belongs to the bucket owner's account, Amazon S3 returns a
    /// `405 Method Not
    /// Allowed` error.
    ///
    /// As a security precaution, the root user of the Amazon Web Services account
    /// that owns a bucket can
    /// always use this action, even if the policy explicitly denies the root user
    /// the ability
    /// to perform this action.
    ///
    /// For more information about bucket policies, see [Using Bucket Policies and
    /// User
    /// Policies](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html).
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketPolicy.html#API_control_DeleteBucketPolicy_Examples) section.
    ///
    /// The following actions are related to `DeleteBucketPolicy`:
    ///
    /// *
    ///   [GetBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketPolicy.html)
    ///
    /// *
    ///   [PutBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketPolicy.html)
    pub fn deleteBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_bucket_policy.DeleteBucketPolicyInput, options: delete_bucket_policy.Options) !delete_bucket_policy.DeleteBucketPolicyOutput {
        return delete_bucket_policy.execute(self, allocator, input, options);
    }

    /// This operation deletes an Amazon S3 on Outposts bucket's replication
    /// configuration. To
    /// delete an S3 bucket's replication configuration, see
    /// [DeleteBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketReplication.html) in the *Amazon S3 API Reference*.
    ///
    /// Deletes the replication configuration from the specified S3 on Outposts
    /// bucket.
    ///
    /// To use this operation, you must have permissions to perform the
    /// `s3-outposts:PutReplicationConfiguration` action. The Outposts bucket owner
    /// has this permission by default and can grant it to others. For more
    /// information about
    /// permissions, see [Setting up IAM with
    /// S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsIAM.html) and [Managing access to
    /// S3 on Outposts
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsBucketPolicy.html) in the *Amazon S3 User Guide*.
    ///
    /// It can take a while to propagate `PUT` or `DELETE` requests for
    /// a replication configuration to all S3 on Outposts systems. Therefore, the
    /// replication
    /// configuration that's returned by a `GET` request soon after a
    /// `PUT` or `DELETE` request might return a more recent result
    /// than what's on the Outpost. If an Outpost is offline, the delay in updating
    /// the
    /// replication configuration on that Outpost can be significant.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketReplication.html#API_control_DeleteBucketReplication_Examples) section.
    ///
    /// For information about S3 replication on Outposts configuration, see
    /// [Replicating objects for S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsReplication.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// The following operations are related to `DeleteBucketReplication`:
    ///
    /// *
    ///   [PutBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketReplication.html)
    ///
    /// *
    ///   [GetBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketReplication.html)
    pub fn deleteBucketReplication(self: *Self, allocator: std.mem.Allocator, input: delete_bucket_replication.DeleteBucketReplicationInput, options: delete_bucket_replication.Options) !delete_bucket_replication.DeleteBucketReplicationOutput {
        return delete_bucket_replication.execute(self, allocator, input, options);
    }

    /// This action deletes an Amazon S3 on Outposts bucket's tags. To delete an S3
    /// bucket tags,
    /// see
    /// [DeleteBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketTagging.html) in the *Amazon S3 API Reference*.
    ///
    /// Deletes the tags from the Outposts bucket. For more information, see [Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `PutBucketTagging` action. By default, the bucket owner has this permission
    /// and can grant this permission to others.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketTagging.html#API_control_DeleteBucketTagging_Examples) section.
    ///
    /// The following actions are related to `DeleteBucketTagging`:
    ///
    /// *
    ///   [GetBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketTagging.html)
    ///
    /// *
    ///   [PutBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketTagging.html)
    pub fn deleteBucketTagging(self: *Self, allocator: std.mem.Allocator, input: delete_bucket_tagging.DeleteBucketTaggingInput, options: delete_bucket_tagging.Options) !delete_bucket_tagging.DeleteBucketTaggingOutput {
        return delete_bucket_tagging.execute(self, allocator, input, options);
    }

    /// Removes the entire tag set from the specified S3 Batch Operations job.
    ///
    /// **Permissions**
    ///
    /// To use the
    /// `DeleteJobTagging` operation, you must have permission to
    /// perform the `s3:DeleteJobTagging` action. For more information, see
    /// [Controlling
    /// access and labeling jobs using
    /// tags](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-managing-jobs.html#batch-ops-job-tags) in the
    /// *Amazon S3 User Guide*.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateJob.html)
    ///
    /// *
    ///   [GetJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetJobTagging.html)
    ///
    /// *
    ///   [PutJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutJobTagging.html)
    pub fn deleteJobTagging(self: *Self, allocator: std.mem.Allocator, input: delete_job_tagging.DeleteJobTaggingInput, options: delete_job_tagging.Options) !delete_job_tagging.DeleteJobTaggingOutput {
        return delete_job_tagging.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Deletes a Multi-Region Access Point. This action does not delete the buckets
    /// associated with the Multi-Region Access Point,
    /// only the Multi-Region Access Point itself.
    ///
    /// This action will always be routed to the US West (Oregon) Region. For more
    /// information
    /// about the restrictions around working with Multi-Region Access Points, see
    /// [Multi-Region Access Point
    /// restrictions and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiRegionAccessPointRestrictions.html) in the *Amazon S3 User Guide*.
    ///
    /// This request is asynchronous, meaning that you might receive a response
    /// before the
    /// command has completed. When this request provides a response, it provides a
    /// token that you
    /// can use to monitor the status of the request with
    /// `DescribeMultiRegionAccessPointOperation`.
    ///
    /// The following actions are related to `DeleteMultiRegionAccessPoint`:
    ///
    /// *
    ///   [CreateMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [DescribeMultiRegionAccessPointOperation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeMultiRegionAccessPointOperation.html)
    ///
    /// *
    ///   [GetMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [ListMultiRegionAccessPoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListMultiRegionAccessPoints.html)
    pub fn deleteMultiRegionAccessPoint(self: *Self, allocator: std.mem.Allocator, input: delete_multi_region_access_point.DeleteMultiRegionAccessPointInput, options: delete_multi_region_access_point.Options) !delete_multi_region_access_point.DeleteMultiRegionAccessPointOutput {
        return delete_multi_region_access_point.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Removes the `PublicAccessBlock` configuration for an Amazon Web Services
    /// account. This
    /// operation might be restricted when the account is managed by
    /// organization-level Block
    /// Public Access policies. You’ll get an Access Denied (403) error when the
    /// account is managed
    /// by organization-level Block Public Access policies. Organization-level
    /// policies override
    /// account-level settings, preventing direct account-level modifications. For
    /// more
    /// information, see [ Using Amazon S3 block
    /// public
    /// access](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html).
    ///
    /// Related actions include:
    ///
    /// *
    ///   [GetPublicAccessBlock](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetPublicAccessBlock.html)
    ///
    /// *
    ///   [PutPublicAccessBlock](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutPublicAccessBlock.html)
    pub fn deletePublicAccessBlock(self: *Self, allocator: std.mem.Allocator, input: delete_public_access_block.DeletePublicAccessBlockInput, options: delete_public_access_block.Options) !delete_public_access_block.DeletePublicAccessBlockOutput {
        return delete_public_access_block.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Deletes the Amazon S3 Storage Lens configuration. For more information about
    /// S3 Storage Lens, see [Assessing your storage
    /// activity and usage with Amazon S3 Storage Lens
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3:DeleteStorageLensConfiguration` action. For more information, see
    /// [Setting permissions to
    /// use Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens_iam_permissions.html) in the *Amazon S3 User Guide*.
    pub fn deleteStorageLensConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_storage_lens_configuration.DeleteStorageLensConfigurationInput, options: delete_storage_lens_configuration.Options) !delete_storage_lens_configuration.DeleteStorageLensConfigurationOutput {
        return delete_storage_lens_configuration.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Deletes the Amazon S3 Storage Lens configuration tags. For more information
    /// about S3 Storage Lens, see
    /// [Assessing your
    /// storage activity and usage with Amazon S3 Storage Lens
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3:DeleteStorageLensConfigurationTagging` action. For more information,
    /// see [Setting permissions to
    /// use Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens_iam_permissions.html) in the *Amazon S3 User Guide*.
    pub fn deleteStorageLensConfigurationTagging(self: *Self, allocator: std.mem.Allocator, input: delete_storage_lens_configuration_tagging.DeleteStorageLensConfigurationTaggingInput, options: delete_storage_lens_configuration_tagging.Options) !delete_storage_lens_configuration_tagging.DeleteStorageLensConfigurationTaggingOutput {
        return delete_storage_lens_configuration_tagging.execute(self, allocator, input, options);
    }

    /// Deletes an existing S3 Storage Lens group.
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3:DeleteStorageLensGroup` action. For more information about the required
    /// Storage Lens
    /// Groups permissions, see [Setting account permissions to use S3 Storage Lens
    /// groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_iam_permissions.html#storage_lens_groups_permissions).
    ///
    /// For information about Storage Lens groups errors, see [List of Amazon S3
    /// Storage
    /// Lens error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3LensErrorCodeList).
    pub fn deleteStorageLensGroup(self: *Self, allocator: std.mem.Allocator, input: delete_storage_lens_group.DeleteStorageLensGroupInput, options: delete_storage_lens_group.Options) !delete_storage_lens_group.DeleteStorageLensGroupOutput {
        return delete_storage_lens_group.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration parameters and status for a Batch Operations
    /// job. For more
    /// information, see [S3 Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/batch-ops.html) in the *Amazon S3 User Guide*.
    ///
    /// **Permissions**
    ///
    /// To use the `DescribeJob` operation, you must have permission to perform the
    /// `s3:DescribeJob` action.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateJob.html)
    ///
    /// *
    ///   [ListJobs](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListJobs.html)
    ///
    /// *
    ///   [UpdateJobPriority](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobPriority.html)
    ///
    /// *
    ///   [UpdateJobStatus](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobStatus.html)
    pub fn describeJob(self: *Self, allocator: std.mem.Allocator, input: describe_job.DescribeJobInput, options: describe_job.Options) !describe_job.DescribeJobOutput {
        return describe_job.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Retrieves the status of an asynchronous request to manage a Multi-Region
    /// Access Point. For more information
    /// about managing Multi-Region Access Points and how asynchronous requests
    /// work, see [Using Multi-Region Access
    /// Points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MrapOperations.html) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to `GetMultiRegionAccessPoint`:
    ///
    /// *
    ///   [CreateMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [DeleteMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [GetMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [ListMultiRegionAccessPoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListMultiRegionAccessPoints.html)
    pub fn describeMultiRegionAccessPointOperation(self: *Self, allocator: std.mem.Allocator, input: describe_multi_region_access_point_operation.DescribeMultiRegionAccessPointOperationInput, options: describe_multi_region_access_point_operation.Options) !describe_multi_region_access_point_operation.DescribeMultiRegionAccessPointOperationOutput {
        return describe_multi_region_access_point_operation.execute(self, allocator, input, options);
    }

    /// Dissociates the Amazon Web Services IAM Identity Center instance from the S3
    /// Access Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:DissociateAccessGrantsIdentityCenter` permission to
    /// use this operation.
    ///
    /// **Additional Permissions**
    ///
    /// You must have the `sso:DeleteApplication` permission to use this operation.
    pub fn dissociateAccessGrantsIdentityCenter(self: *Self, allocator: std.mem.Allocator, input: dissociate_access_grants_identity_center.DissociateAccessGrantsIdentityCenterInput, options: dissociate_access_grants_identity_center.Options) !dissociate_access_grants_identity_center.DissociateAccessGrantsIdentityCenterOutput {
        return dissociate_access_grants_identity_center.execute(self, allocator, input, options);
    }

    /// Get the details of an access grant from your S3 Access Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:GetAccessGrant` permission to use this operation.
    pub fn getAccessGrant(self: *Self, allocator: std.mem.Allocator, input: get_access_grant.GetAccessGrantInput, options: get_access_grant.Options) !get_access_grant.GetAccessGrantOutput {
        return get_access_grant.execute(self, allocator, input, options);
    }

    /// Retrieves the S3 Access Grants instance for a Region in your account.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:GetAccessGrantsInstance` permission to use this
    /// operation.
    ///
    /// `GetAccessGrantsInstance` is not supported for cross-account access. You can
    /// only call the API from the account that owns the S3 Access Grants instance.
    pub fn getAccessGrantsInstance(self: *Self, allocator: std.mem.Allocator, input: get_access_grants_instance.GetAccessGrantsInstanceInput, options: get_access_grants_instance.Options) !get_access_grants_instance.GetAccessGrantsInstanceOutput {
        return get_access_grants_instance.execute(self, allocator, input, options);
    }

    /// Retrieve the S3 Access Grants instance that contains a particular prefix.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:GetAccessGrantsInstanceForPrefix` permission for the
    /// caller account to use this operation.
    ///
    /// **Additional Permissions**
    ///
    /// The prefix owner account must grant you the following permissions to their
    /// S3 Access Grants instance: `s3:GetAccessGrantsInstanceForPrefix`.
    pub fn getAccessGrantsInstanceForPrefix(self: *Self, allocator: std.mem.Allocator, input: get_access_grants_instance_for_prefix.GetAccessGrantsInstanceForPrefixInput, options: get_access_grants_instance_for_prefix.Options) !get_access_grants_instance_for_prefix.GetAccessGrantsInstanceForPrefixOutput {
        return get_access_grants_instance_for_prefix.execute(self, allocator, input, options);
    }

    /// Returns the resource policy of the S3 Access Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:GetAccessGrantsInstanceResourcePolicy` permission to
    /// use this operation.
    pub fn getAccessGrantsInstanceResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_access_grants_instance_resource_policy.GetAccessGrantsInstanceResourcePolicyInput, options: get_access_grants_instance_resource_policy.Options) !get_access_grants_instance_resource_policy.GetAccessGrantsInstanceResourcePolicyOutput {
        return get_access_grants_instance_resource_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a particular location registered in your S3 Access
    /// Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:GetAccessGrantsLocation` permission to use this
    /// operation.
    pub fn getAccessGrantsLocation(self: *Self, allocator: std.mem.Allocator, input: get_access_grants_location.GetAccessGrantsLocationInput, options: get_access_grants_location.Options) !get_access_grants_location.GetAccessGrantsLocationOutput {
        return get_access_grants_location.execute(self, allocator, input, options);
    }

    /// Returns configuration information about the specified access point.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPoint.html#API_control_GetAccessPoint_Examples) section.
    ///
    /// The following actions are related to `GetAccessPoint`:
    ///
    /// *
    ///   [CreateAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPoint.html)
    ///
    /// *
    ///   [DeleteAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPoint.html)
    ///
    /// *
    ///   [ListAccessPoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPoints.html)
    pub fn getAccessPoint(self: *Self, allocator: std.mem.Allocator, input: get_access_point.GetAccessPointInput, options: get_access_point.Options) !get_access_point.GetAccessPointOutput {
        return get_access_point.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns configuration for an Object Lambda Access Point.
    ///
    /// The following actions are related to
    /// `GetAccessPointConfigurationForObjectLambda`:
    ///
    /// *
    ///   [PutAccessPointConfigurationForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutAccessPointConfigurationForObjectLambda.html)
    pub fn getAccessPointConfigurationForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: get_access_point_configuration_for_object_lambda.GetAccessPointConfigurationForObjectLambdaInput, options: get_access_point_configuration_for_object_lambda.Options) !get_access_point_configuration_for_object_lambda.GetAccessPointConfigurationForObjectLambdaOutput {
        return get_access_point_configuration_for_object_lambda.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns configuration information about the specified Object Lambda Access
    /// Point
    ///
    /// The following actions are related to `GetAccessPointForObjectLambda`:
    ///
    /// *
    ///   [CreateAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [DeleteAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [ListAccessPointsForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPointsForObjectLambda.html)
    pub fn getAccessPointForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: get_access_point_for_object_lambda.GetAccessPointForObjectLambdaInput, options: get_access_point_for_object_lambda.Options) !get_access_point_for_object_lambda.GetAccessPointForObjectLambdaOutput {
        return get_access_point_for_object_lambda.execute(self, allocator, input, options);
    }

    /// Returns the access point policy associated with the specified access point.
    ///
    /// The following actions are related to `GetAccessPointPolicy`:
    ///
    /// *
    ///   [PutAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutAccessPointPolicy.html)
    ///
    /// *
    ///   [DeleteAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointPolicy.html)
    pub fn getAccessPointPolicy(self: *Self, allocator: std.mem.Allocator, input: get_access_point_policy.GetAccessPointPolicyInput, options: get_access_point_policy.Options) !get_access_point_policy.GetAccessPointPolicyOutput {
        return get_access_point_policy.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns the resource policy for an Object Lambda Access Point.
    ///
    /// The following actions are related to
    /// `GetAccessPointPolicyForObjectLambda`:
    ///
    /// *
    ///   [DeleteAccessPointPolicyForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointPolicyForObjectLambda.html)
    ///
    /// *
    ///   [PutAccessPointPolicyForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutAccessPointPolicyForObjectLambda.html)
    pub fn getAccessPointPolicyForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: get_access_point_policy_for_object_lambda.GetAccessPointPolicyForObjectLambdaInput, options: get_access_point_policy_for_object_lambda.Options) !get_access_point_policy_for_object_lambda.GetAccessPointPolicyForObjectLambdaOutput {
        return get_access_point_policy_for_object_lambda.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Indicates whether the specified access point currently has a policy that
    /// allows public access.
    /// For more information about public access through access points, see
    /// [Managing Data Access with Amazon S3
    /// access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points.html) in the *Amazon S3 User Guide*.
    pub fn getAccessPointPolicyStatus(self: *Self, allocator: std.mem.Allocator, input: get_access_point_policy_status.GetAccessPointPolicyStatusInput, options: get_access_point_policy_status.Options) !get_access_point_policy_status.GetAccessPointPolicyStatusOutput {
        return get_access_point_policy_status.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns the status of the resource policy associated with an Object Lambda
    /// Access Point.
    pub fn getAccessPointPolicyStatusForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: get_access_point_policy_status_for_object_lambda.GetAccessPointPolicyStatusForObjectLambdaInput, options: get_access_point_policy_status_for_object_lambda.Options) !get_access_point_policy_status_for_object_lambda.GetAccessPointPolicyStatusForObjectLambdaOutput {
        return get_access_point_policy_status_for_object_lambda.execute(self, allocator, input, options);
    }

    /// Returns the access point scope for a directory bucket.
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3express:GetAccessPointScope` action.
    ///
    /// For information about REST API errors, see [REST error
    /// responses](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#RESTErrorResponses).
    pub fn getAccessPointScope(self: *Self, allocator: std.mem.Allocator, input: get_access_point_scope.GetAccessPointScopeInput, options: get_access_point_scope.Options) !get_access_point_scope.GetAccessPointScopeOutput {
        return get_access_point_scope.execute(self, allocator, input, options);
    }

    /// Gets an Amazon S3 on Outposts bucket. For more information, see [ Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// If you are using an identity other than the root user of the Amazon Web
    /// Services account that owns the
    /// Outposts bucket, the calling identity must have the `s3-outposts:GetBucket`
    /// permissions on the specified Outposts bucket and belong to the Outposts
    /// bucket owner's
    /// account in order to use this action. Only users from Outposts bucket owner
    /// account with
    /// the right permissions can perform actions on an Outposts bucket.
    ///
    /// If you don't have `s3-outposts:GetBucket` permissions or you're not using an
    /// identity that belongs to the bucket owner's account, Amazon S3 returns a
    /// `403 Access
    /// Denied` error.
    ///
    /// The following actions are related to `GetBucket` for Amazon S3 on Outposts:
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucket.html#API_control_GetBucket_Examples) section.
    ///
    /// *
    ///   [PutObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
    ///
    /// *
    ///   [CreateBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateBucket.html)
    ///
    /// *
    ///   [DeleteBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucket.html)
    pub fn getBucket(self: *Self, allocator: std.mem.Allocator, input: get_bucket.GetBucketInput, options: get_bucket.Options) !get_bucket.GetBucketOutput {
        return get_bucket.execute(self, allocator, input, options);
    }

    /// This action gets an Amazon S3 on Outposts bucket's lifecycle configuration.
    /// To get an S3
    /// bucket's lifecycle configuration, see
    /// [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html) in the *Amazon S3 API Reference*.
    ///
    /// Returns the lifecycle configuration information set on the Outposts bucket.
    /// For more
    /// information, see [Using Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) and for
    /// information about lifecycle configuration, see [ Object Lifecycle
    /// Management](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html) in *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3-outposts:GetLifecycleConfiguration` action. The Outposts bucket owner
    /// has this permission, by default. The bucket owner can grant this permission
    /// to others. For
    /// more information about permissions, see [Permissions Related to Bucket
    /// Subresource
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources) and [Managing
    /// Access Permissions to Your Amazon S3
    /// Resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html).
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketLifecycleConfiguration.html#API_control_GetBucketLifecycleConfiguration_Examples) section.
    ///
    /// `GetBucketLifecycleConfiguration` has the following special error:
    ///
    /// * Error code: `NoSuchLifecycleConfiguration`
    ///
    /// * Description: The lifecycle configuration does not exist.
    ///
    /// * HTTP Status Code: 404 Not Found
    ///
    /// * SOAP Fault Code Prefix: Client
    ///
    /// The following actions are related to
    /// `GetBucketLifecycleConfiguration`:
    ///
    /// *
    ///   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketLifecycleConfiguration.html)
    ///
    /// *
    ///   [DeleteBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketLifecycleConfiguration.html)
    pub fn getBucketLifecycleConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_bucket_lifecycle_configuration.GetBucketLifecycleConfigurationInput, options: get_bucket_lifecycle_configuration.Options) !get_bucket_lifecycle_configuration.GetBucketLifecycleConfigurationOutput {
        return get_bucket_lifecycle_configuration.execute(self, allocator, input, options);
    }

    /// This action gets a bucket policy for an Amazon S3 on Outposts bucket. To get
    /// a policy for
    /// an S3 bucket, see
    /// [GetBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketPolicy.html) in the
    /// *Amazon S3 API Reference*.
    ///
    /// Returns the policy of a specified Outposts bucket. For more information, see
    /// [Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    ///
    /// If you are using an identity other than the root user of the Amazon Web
    /// Services account that owns the
    /// bucket, the calling identity must have the `GetBucketPolicy` permissions on
    /// the
    /// specified bucket and belong to the bucket owner's account in order to use
    /// this
    /// action.
    ///
    /// Only users from Outposts bucket owner account with the right permissions can
    /// perform
    /// actions on an Outposts bucket. If you don't have
    /// `s3-outposts:GetBucketPolicy`
    /// permissions or you're not using an identity that belongs to the bucket
    /// owner's account,
    /// Amazon S3 returns a `403 Access Denied` error.
    ///
    /// As a security precaution, the root user of the Amazon Web Services account
    /// that owns a bucket can
    /// always use this action, even if the policy explicitly denies the root user
    /// the ability
    /// to perform this action.
    ///
    /// For more information about bucket policies, see [Using Bucket Policies and
    /// User
    /// Policies](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html).
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketPolicy.html#API_control_GetBucketPolicy_Examples) section.
    ///
    /// The following actions are related to `GetBucketPolicy`:
    ///
    /// *
    ///   [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
    ///
    /// *
    ///   [PutBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketPolicy.html)
    ///
    /// *
    ///   [DeleteBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketPolicy.html)
    pub fn getBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: get_bucket_policy.GetBucketPolicyInput, options: get_bucket_policy.Options) !get_bucket_policy.GetBucketPolicyOutput {
        return get_bucket_policy.execute(self, allocator, input, options);
    }

    /// This operation gets an Amazon S3 on Outposts bucket's replication
    /// configuration. To get an
    /// S3 bucket's replication configuration, see
    /// [GetBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketReplication.html)
    /// in the *Amazon S3 API Reference*.
    ///
    /// Returns the replication configuration of an S3 on Outposts bucket. For more
    /// information
    /// about S3 on Outposts, see [Using Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the
    /// *Amazon S3 User Guide*. For information about S3 replication on Outposts
    /// configuration, see [Replicating objects for
    /// S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsReplication.html) in the *Amazon S3 User Guide*.
    ///
    /// It can take a while to propagate `PUT` or `DELETE` requests for
    /// a replication configuration to all S3 on Outposts systems. Therefore, the
    /// replication
    /// configuration that's returned by a `GET` request soon after a
    /// `PUT` or `DELETE` request might return a more recent result
    /// than what's on the Outpost. If an Outpost is offline, the delay in updating
    /// the
    /// replication configuration on that Outpost can be significant.
    ///
    /// This action requires permissions for the
    /// `s3-outposts:GetReplicationConfiguration` action. The Outposts bucket owner
    /// has this permission by default and can grant it to others. For more
    /// information about
    /// permissions, see [Setting up IAM with
    /// S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsIAM.html) and [Managing access to
    /// S3 on Outposts
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsBucketPolicy.html) in the *Amazon S3 User Guide*.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketReplication.html#API_control_GetBucketReplication_Examples) section.
    ///
    /// If you include the `Filter` element in a replication configuration, you must
    /// also include the `DeleteMarkerReplication`, `Status`, and
    /// `Priority` elements. The response also returns those elements.
    ///
    /// For information about S3 on Outposts replication failure reasons, see
    /// [Replication failure
    /// reasons](https://docs.aws.amazon.com/AmazonS3/latest/userguide/outposts-replication-eventbridge.html#outposts-replication-failure-codes) in the *Amazon S3 User Guide*.
    ///
    /// The following operations are related to `GetBucketReplication`:
    ///
    /// *
    ///   [PutBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketReplication.html)
    ///
    /// *
    ///   [DeleteBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketReplication.html)
    pub fn getBucketReplication(self: *Self, allocator: std.mem.Allocator, input: get_bucket_replication.GetBucketReplicationInput, options: get_bucket_replication.Options) !get_bucket_replication.GetBucketReplicationOutput {
        return get_bucket_replication.execute(self, allocator, input, options);
    }

    /// This action gets an Amazon S3 on Outposts bucket's tags. To get an S3 bucket
    /// tags, see
    /// [GetBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketTagging.html) in the *Amazon S3 API Reference*.
    ///
    /// Returns the tag set associated with the Outposts bucket. For more
    /// information, see
    /// [Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `GetBucketTagging` action. By default, the bucket owner has this permission
    /// and can grant this permission to others.
    ///
    /// `GetBucketTagging` has the following special error:
    ///
    /// * Error code: `NoSuchTagSetError`
    ///
    /// * Description: There is no tag set associated with the bucket.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketTagging.html#API_control_GetBucketTagging_Examples) section.
    ///
    /// The following actions are related to `GetBucketTagging`:
    ///
    /// *
    ///   [PutBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketTagging.html)
    ///
    /// *
    ///   [DeleteBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketTagging.html)
    pub fn getBucketTagging(self: *Self, allocator: std.mem.Allocator, input: get_bucket_tagging.GetBucketTaggingInput, options: get_bucket_tagging.Options) !get_bucket_tagging.GetBucketTaggingOutput {
        return get_bucket_tagging.execute(self, allocator, input, options);
    }

    /// This operation returns the versioning state
    /// for
    /// S3 on Outposts
    /// buckets
    /// only. To return the versioning state for an S3 bucket, see
    /// [GetBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketVersioning.html) in the *Amazon S3 API Reference*.
    ///
    /// Returns the versioning state for an S3 on Outposts bucket. With
    /// S3
    /// Versioning,
    /// you can save multiple distinct copies of your
    /// objects
    /// and recover from unintended user actions and application failures.
    ///
    /// If you've never set versioning on your bucket, it has no versioning state.
    /// In that case,
    /// the `GetBucketVersioning` request does not return a versioning state
    /// value.
    ///
    /// For more information about versioning, see
    /// [Versioning](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Versioning.html) in the *Amazon S3
    /// User Guide*.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketVersioning.html#API_control_GetBucketVersioning_Examples) section.
    ///
    /// The following operations are related to `GetBucketVersioning` for
    /// S3 on Outposts.
    ///
    /// *
    ///   [PutBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketVersioning.html)
    ///
    /// *
    ///   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketLifecycleConfiguration.html)
    ///
    /// *
    ///   [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketLifecycleConfiguration.html)
    pub fn getBucketVersioning(self: *Self, allocator: std.mem.Allocator, input: get_bucket_versioning.GetBucketVersioningInput, options: get_bucket_versioning.Options) !get_bucket_versioning.GetBucketVersioningOutput {
        return get_bucket_versioning.execute(self, allocator, input, options);
    }

    /// Returns a temporary access credential from S3 Access Grants to the grantee
    /// or client application. The [temporary
    /// credential](https://docs.aws.amazon.com/STS/latest/APIReference/API_Credentials.html) is an Amazon Web Services STS token that grants them access to the S3 data.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:GetDataAccess` permission to use this operation.
    ///
    /// **Additional Permissions**
    ///
    /// The IAM role that S3 Access Grants assumes must have the following
    /// permissions specified in the trust policy when registering the location:
    /// `sts:AssumeRole`, for directory users or groups `sts:SetContext`, and for
    /// IAM users or roles `sts:SetSourceIdentity`.
    pub fn getDataAccess(self: *Self, allocator: std.mem.Allocator, input: get_data_access.GetDataAccessInput, options: get_data_access.Options) !get_data_access.GetDataAccessOutput {
        return get_data_access.execute(self, allocator, input, options);
    }

    /// Returns the tags on an S3 Batch Operations job.
    ///
    /// **Permissions**
    ///
    /// To use the
    /// `GetJobTagging` operation, you must have permission to
    /// perform the `s3:GetJobTagging` action. For more information, see
    /// [Controlling
    /// access and labeling jobs using
    /// tags](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-managing-jobs.html#batch-ops-job-tags) in the
    /// *Amazon S3 User Guide*.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateJob.html)
    ///
    /// *
    ///   [PutJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutJobTagging.html)
    ///
    /// *
    ///   [DeleteJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteJobTagging.html)
    pub fn getJobTagging(self: *Self, allocator: std.mem.Allocator, input: get_job_tagging.GetJobTaggingInput, options: get_job_tagging.Options) !get_job_tagging.GetJobTaggingOutput {
        return get_job_tagging.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns configuration information about the specified Multi-Region Access
    /// Point.
    ///
    /// This action will always be routed to the US West (Oregon) Region. For more
    /// information
    /// about the restrictions around working with Multi-Region Access Points, see
    /// [Multi-Region Access Point
    /// restrictions and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiRegionAccessPointRestrictions.html) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to `GetMultiRegionAccessPoint`:
    ///
    /// *
    ///   [CreateMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [DeleteMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [DescribeMultiRegionAccessPointOperation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeMultiRegionAccessPointOperation.html)
    ///
    /// *
    ///   [ListMultiRegionAccessPoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListMultiRegionAccessPoints.html)
    pub fn getMultiRegionAccessPoint(self: *Self, allocator: std.mem.Allocator, input: get_multi_region_access_point.GetMultiRegionAccessPointInput, options: get_multi_region_access_point.Options) !get_multi_region_access_point.GetMultiRegionAccessPointOutput {
        return get_multi_region_access_point.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns the access control policy of the specified Multi-Region Access
    /// Point.
    ///
    /// This action will always be routed to the US West (Oregon) Region. For more
    /// information
    /// about the restrictions around working with Multi-Region Access Points, see
    /// [Multi-Region Access Point
    /// restrictions and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiRegionAccessPointRestrictions.html) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to
    /// `GetMultiRegionAccessPointPolicy`:
    ///
    /// *
    ///   [GetMultiRegionAccessPointPolicyStatus](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPointPolicyStatus.html)
    ///
    /// *
    ///   [PutMultiRegionAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutMultiRegionAccessPointPolicy.html)
    pub fn getMultiRegionAccessPointPolicy(self: *Self, allocator: std.mem.Allocator, input: get_multi_region_access_point_policy.GetMultiRegionAccessPointPolicyInput, options: get_multi_region_access_point_policy.Options) !get_multi_region_access_point_policy.GetMultiRegionAccessPointPolicyOutput {
        return get_multi_region_access_point_policy.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Indicates whether the specified Multi-Region Access Point has an access
    /// control policy that allows public
    /// access.
    ///
    /// This action will always be routed to the US West (Oregon) Region. For more
    /// information
    /// about the restrictions around working with Multi-Region Access Points, see
    /// [Multi-Region Access Point
    /// restrictions and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiRegionAccessPointRestrictions.html) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to
    /// `GetMultiRegionAccessPointPolicyStatus`:
    ///
    /// *
    ///   [GetMultiRegionAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPointPolicy.html)
    ///
    /// *
    ///   [PutMultiRegionAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutMultiRegionAccessPointPolicy.html)
    pub fn getMultiRegionAccessPointPolicyStatus(self: *Self, allocator: std.mem.Allocator, input: get_multi_region_access_point_policy_status.GetMultiRegionAccessPointPolicyStatusInput, options: get_multi_region_access_point_policy_status.Options) !get_multi_region_access_point_policy_status.GetMultiRegionAccessPointPolicyStatusOutput {
        return get_multi_region_access_point_policy_status.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns the routing configuration for a Multi-Region Access Point,
    /// indicating which Regions are active or
    /// passive.
    ///
    /// To obtain routing control changes and failover requests, use the Amazon S3
    /// failover control
    /// infrastructure endpoints in these five Amazon Web Services Regions:
    ///
    /// * `us-east-1`
    ///
    /// * `us-west-2`
    ///
    /// * `ap-southeast-2`
    ///
    /// * `ap-northeast-1`
    ///
    /// * `eu-west-1`
    pub fn getMultiRegionAccessPointRoutes(self: *Self, allocator: std.mem.Allocator, input: get_multi_region_access_point_routes.GetMultiRegionAccessPointRoutesInput, options: get_multi_region_access_point_routes.Options) !get_multi_region_access_point_routes.GetMultiRegionAccessPointRoutesOutput {
        return get_multi_region_access_point_routes.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Retrieves the `PublicAccessBlock` configuration for an Amazon Web Services
    /// account. This
    /// operation returns the effective account-level configuration, which may
    /// inherit from
    /// organization-level policies. For more information, see [ Using Amazon S3
    /// block
    /// public
    /// access](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html).
    ///
    /// Related actions include:
    ///
    /// *
    ///   [DeletePublicAccessBlock](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeletePublicAccessBlock.html)
    ///
    /// *
    ///   [PutPublicAccessBlock](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutPublicAccessBlock.html)
    pub fn getPublicAccessBlock(self: *Self, allocator: std.mem.Allocator, input: get_public_access_block.GetPublicAccessBlockInput, options: get_public_access_block.Options) !get_public_access_block.GetPublicAccessBlockOutput {
        return get_public_access_block.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Gets the Amazon S3 Storage Lens configuration. For more information, see
    /// [Assessing your storage
    /// activity and usage with Amazon S3 Storage Lens
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens.html) in the
    /// *Amazon S3 User Guide*. For a complete list of S3 Storage Lens metrics, see
    /// [S3 Storage Lens metrics
    /// glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html) in the *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3:GetStorageLensConfiguration` action. For more information, see [Setting
    /// permissions to use Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens_iam_permissions.html) in the
    /// *Amazon S3 User Guide*.
    pub fn getStorageLensConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_storage_lens_configuration.GetStorageLensConfigurationInput, options: get_storage_lens_configuration.Options) !get_storage_lens_configuration.GetStorageLensConfigurationOutput {
        return get_storage_lens_configuration.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Gets the tags of Amazon S3 Storage Lens configuration. For more information
    /// about S3 Storage Lens, see
    /// [Assessing your
    /// storage activity and usage with Amazon S3 Storage Lens
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3:GetStorageLensConfigurationTagging` action. For more information, see
    /// [Setting permissions to
    /// use Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens_iam_permissions.html) in the *Amazon S3 User Guide*.
    pub fn getStorageLensConfigurationTagging(self: *Self, allocator: std.mem.Allocator, input: get_storage_lens_configuration_tagging.GetStorageLensConfigurationTaggingInput, options: get_storage_lens_configuration_tagging.Options) !get_storage_lens_configuration_tagging.GetStorageLensConfigurationTaggingOutput {
        return get_storage_lens_configuration_tagging.execute(self, allocator, input, options);
    }

    /// Retrieves the Storage Lens group configuration details.
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3:GetStorageLensGroup` action. For more information about the required
    /// Storage Lens
    /// Groups permissions, see [Setting account permissions to use S3 Storage Lens
    /// groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_iam_permissions.html#storage_lens_groups_permissions).
    ///
    /// For information about Storage Lens groups errors, see [List of Amazon S3
    /// Storage
    /// Lens error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3LensErrorCodeList).
    pub fn getStorageLensGroup(self: *Self, allocator: std.mem.Allocator, input: get_storage_lens_group.GetStorageLensGroupInput, options: get_storage_lens_group.Options) !get_storage_lens_group.GetStorageLensGroupOutput {
        return get_storage_lens_group.execute(self, allocator, input, options);
    }

    /// Returns the list of access grants in your S3 Access Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:ListAccessGrants` permission to use this operation.
    pub fn listAccessGrants(self: *Self, allocator: std.mem.Allocator, input: list_access_grants.ListAccessGrantsInput, options: list_access_grants.Options) !list_access_grants.ListAccessGrantsOutput {
        return list_access_grants.execute(self, allocator, input, options);
    }

    /// Returns a list of S3 Access Grants instances. An S3 Access Grants instance
    /// serves as a logical grouping for your individual access grants. You can only
    /// have one S3 Access Grants instance per Region per account.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:ListAccessGrantsInstances` permission to use this
    /// operation.
    pub fn listAccessGrantsInstances(self: *Self, allocator: std.mem.Allocator, input: list_access_grants_instances.ListAccessGrantsInstancesInput, options: list_access_grants_instances.Options) !list_access_grants_instances.ListAccessGrantsInstancesOutput {
        return list_access_grants_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of the locations registered in your S3 Access Grants
    /// instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:ListAccessGrantsLocations` permission to use this
    /// operation.
    pub fn listAccessGrantsLocations(self: *Self, allocator: std.mem.Allocator, input: list_access_grants_locations.ListAccessGrantsLocationsInput, options: list_access_grants_locations.Options) !list_access_grants_locations.ListAccessGrantsLocationsOutput {
        return list_access_grants_locations.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns a list of the access points. You can retrieve up to 1,000 access
    /// points per call. If the call
    /// returns more than 1,000 access points (or the number specified in
    /// `maxResults`,
    /// whichever is less), the response will include a continuation token that you
    /// can use to list
    /// the additional access points.
    ///
    /// Returns only access points attached to S3 buckets by default. To return all
    /// access points specify
    /// `DataSourceType` as `ALL`.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPoint.html#API_control_GetAccessPoint_Examples) section.
    ///
    /// The following actions are related to `ListAccessPoints`:
    ///
    /// *
    ///   [CreateAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPoint.html)
    ///
    /// *
    ///   [DeleteAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPoint.html)
    ///
    /// *
    ///   [GetAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPoint.html)
    pub fn listAccessPoints(self: *Self, allocator: std.mem.Allocator, input: list_access_points.ListAccessPointsInput, options: list_access_points.Options) !list_access_points.ListAccessPointsOutput {
        return list_access_points.execute(self, allocator, input, options);
    }

    /// Returns a list of the access points that are owned by the Amazon Web
    /// Services account and that are associated with the specified directory
    /// bucket.
    ///
    /// To list access points for general purpose buckets, see
    /// [ListAccesspoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListAccessPoints.html).
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3express:ListAccessPointsForDirectoryBuckets` action.
    ///
    /// For information about REST API errors, see [REST error
    /// responses](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#RESTErrorResponses).
    pub fn listAccessPointsForDirectoryBuckets(self: *Self, allocator: std.mem.Allocator, input: list_access_points_for_directory_buckets.ListAccessPointsForDirectoryBucketsInput, options: list_access_points_for_directory_buckets.Options) !list_access_points_for_directory_buckets.ListAccessPointsForDirectoryBucketsOutput {
        return list_access_points_for_directory_buckets.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns some or all (up to 1,000) access points associated with the Object
    /// Lambda Access Point per call. If there
    /// are more access points than what can be returned in one call, the response
    /// will include a
    /// continuation token that you can use to list the additional access points.
    ///
    /// The following actions are related to
    /// `ListAccessPointsForObjectLambda`:
    ///
    /// *
    ///   [CreateAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [DeleteAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointForObjectLambda.html)
    ///
    /// *
    ///   [GetAccessPointForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointForObjectLambda.html)
    pub fn listAccessPointsForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: list_access_points_for_object_lambda.ListAccessPointsForObjectLambdaInput, options: list_access_points_for_object_lambda.Options) !list_access_points_for_object_lambda.ListAccessPointsForObjectLambdaOutput {
        return list_access_points_for_object_lambda.execute(self, allocator, input, options);
    }

    /// Use this API to list the access grants that grant the caller access to
    /// Amazon S3 data through S3 Access Grants. The caller (grantee) can be an
    /// Identity and Access Management (IAM) identity or Amazon Web Services
    /// Identity Center corporate directory identity. You must pass the Amazon Web
    /// Services account of the S3 data owner (grantor) in the request. You can,
    /// optionally, narrow the results by `GrantScope`, using a fragment of the
    /// data's S3 path, and S3 Access Grants will return only the grants with a path
    /// that contains the path fragment. You can also pass the
    /// `AllowedByApplication` filter in the request, which returns only the grants
    /// authorized for applications, whether the application is the caller's
    /// Identity Center application or any other application (`ALL`). For more
    /// information, see [List the caller's access
    /// grants](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-grants-list-grants.html) in the *Amazon S3 User Guide*.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:ListCallerAccessGrants` permission to use this
    /// operation.
    pub fn listCallerAccessGrants(self: *Self, allocator: std.mem.Allocator, input: list_caller_access_grants.ListCallerAccessGrantsInput, options: list_caller_access_grants.Options) !list_caller_access_grants.ListCallerAccessGrantsOutput {
        return list_caller_access_grants.execute(self, allocator, input, options);
    }

    /// Lists current S3 Batch Operations jobs as well as the jobs that have ended
    /// within the last 90
    /// days for the Amazon Web Services account making the request. For more
    /// information, see [S3 Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/batch-ops.html) in the *Amazon S3 User Guide*.
    ///
    /// **Permissions**
    ///
    /// To use the
    /// `ListJobs` operation, you must have permission to
    /// perform the `s3:ListJobs` action.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateJob.html)
    ///
    /// *
    ///   [DescribeJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeJob.html)
    ///
    /// *
    ///   [UpdateJobPriority](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobPriority.html)
    ///
    /// *
    ///   [UpdateJobStatus](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobStatus.html)
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: list_jobs.Options) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns a list of the Multi-Region Access Points currently associated with
    /// the specified Amazon Web Services account.
    /// Each call can return up to 100 Multi-Region Access Points, the maximum
    /// number of Multi-Region Access Points that can be
    /// associated with a single account.
    ///
    /// This action will always be routed to the US West (Oregon) Region. For more
    /// information
    /// about the restrictions around working with Multi-Region Access Points, see
    /// [Multi-Region Access Point
    /// restrictions and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiRegionAccessPointRestrictions.html) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to `ListMultiRegionAccessPoint`:
    ///
    /// *
    ///   [CreateMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [DeleteMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteMultiRegionAccessPoint.html)
    ///
    /// *
    ///   [DescribeMultiRegionAccessPointOperation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeMultiRegionAccessPointOperation.html)
    ///
    /// *
    ///   [GetMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPoint.html)
    pub fn listMultiRegionAccessPoints(self: *Self, allocator: std.mem.Allocator, input: list_multi_region_access_points.ListMultiRegionAccessPointsInput, options: list_multi_region_access_points.Options) !list_multi_region_access_points.ListMultiRegionAccessPointsOutput {
        return list_multi_region_access_points.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Returns a list of all Outposts buckets in an Outpost that are owned by the
    /// authenticated
    /// sender of the request. For more information, see [Using Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// For an example of the request syntax for Amazon S3 on Outposts that uses the
    /// S3 on Outposts
    /// endpoint hostname prefix and `x-amz-outpost-id` in your request, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListRegionalBuckets.html#API_control_ListRegionalBuckets_Examples) section.
    pub fn listRegionalBuckets(self: *Self, allocator: std.mem.Allocator, input: list_regional_buckets.ListRegionalBucketsInput, options: list_regional_buckets.Options) !list_regional_buckets.ListRegionalBucketsOutput {
        return list_regional_buckets.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Gets a list of Amazon S3 Storage Lens configurations. For more information
    /// about S3 Storage Lens, see
    /// [Assessing your
    /// storage activity and usage with Amazon S3 Storage Lens
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3:ListStorageLensConfigurations` action. For more information, see
    /// [Setting permissions to
    /// use Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens_iam_permissions.html) in the *Amazon S3 User Guide*.
    pub fn listStorageLensConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_storage_lens_configurations.ListStorageLensConfigurationsInput, options: list_storage_lens_configurations.Options) !list_storage_lens_configurations.ListStorageLensConfigurationsOutput {
        return list_storage_lens_configurations.execute(self, allocator, input, options);
    }

    /// Lists all the Storage Lens groups in the specified home Region.
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3:ListStorageLensGroups` action. For more information about the required
    /// Storage Lens
    /// Groups permissions, see [Setting account permissions to use S3 Storage Lens
    /// groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_iam_permissions.html#storage_lens_groups_permissions).
    ///
    /// For information about Storage Lens groups errors, see [List of Amazon S3
    /// Storage
    /// Lens error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3LensErrorCodeList).
    pub fn listStorageLensGroups(self: *Self, allocator: std.mem.Allocator, input: list_storage_lens_groups.ListStorageLensGroupsInput, options: list_storage_lens_groups.Options) !list_storage_lens_groups.ListStorageLensGroupsOutput {
        return list_storage_lens_groups.execute(self, allocator, input, options);
    }

    /// This operation allows you to list all of the tags for a specified resource.
    /// Each tag is a label consisting of a key and value. Tags can help you
    /// organize, track costs for, and control access to resources.
    ///
    /// This operation is only supported for the following Amazon S3 resources:
    ///
    /// * [General purpose
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/buckets-tagging.html)
    ///
    /// * [Access Points for directory
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-db-tagging.html)
    ///
    /// * [Access Points for general purpose
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-tagging.html)
    ///
    /// * [Directory
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-tagging.html)
    ///
    /// * [S3 Storage Lens
    ///   groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-lens-groups.html)
    ///
    /// * [S3 Access Grants instances, registered locations, and
    ///   grants](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-grants-tagging.html).
    ///
    /// **Permissions**
    ///
    /// For general purpose buckets, access points for general purpose buckets,
    /// Storage Lens groups, and S3 Access Grants, you must have the
    /// `s3:ListTagsForResource` permission to use this operation.
    ///
    /// **Directory bucket permissions**
    ///
    /// For directory buckets, you must have the `s3express:ListTagsForResource`
    /// permission to use this operation. For more information about directory
    /// buckets policies and permissions, see [Identity and Access Management (IAM)
    /// for S3 Express One
    /// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-permissions.html) in the *Amazon S3 User Guide*.
    ///
    /// **HTTP Host header syntax**
    ///
    /// **Directory buckets ** - The HTTP Host header syntax is
    /// `s3express-control.*region*.amazonaws.com`.
    ///
    /// For information about S3 Tagging errors, see [List of Amazon S3 Tagging
    /// error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3TaggingErrorCodeList).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Updates the resource policy of the S3 Access Grants instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:PutAccessGrantsInstanceResourcePolicy` permission to
    /// use this operation.
    pub fn putAccessGrantsInstanceResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_access_grants_instance_resource_policy.PutAccessGrantsInstanceResourcePolicyInput, options: put_access_grants_instance_resource_policy.Options) !put_access_grants_instance_resource_policy.PutAccessGrantsInstanceResourcePolicyOutput {
        return put_access_grants_instance_resource_policy.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Replaces configuration for an Object Lambda Access Point.
    ///
    /// The following actions are related to
    /// `PutAccessPointConfigurationForObjectLambda`:
    ///
    /// *
    ///   [GetAccessPointConfigurationForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointConfigurationForObjectLambda.html)
    pub fn putAccessPointConfigurationForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: put_access_point_configuration_for_object_lambda.PutAccessPointConfigurationForObjectLambdaInput, options: put_access_point_configuration_for_object_lambda.Options) !put_access_point_configuration_for_object_lambda.PutAccessPointConfigurationForObjectLambdaOutput {
        return put_access_point_configuration_for_object_lambda.execute(self, allocator, input, options);
    }

    /// Associates an access policy with the specified access point. Each access
    /// point can have only one policy,
    /// so a request made to this API replaces any existing policy associated with
    /// the specified
    /// access point.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutAccessPointPolicy.html#API_control_PutAccessPointPolicy_Examples) section.
    ///
    /// The following actions are related to `PutAccessPointPolicy`:
    ///
    /// *
    ///   [GetAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointPolicy.html)
    ///
    /// *
    ///   [DeleteAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointPolicy.html)
    pub fn putAccessPointPolicy(self: *Self, allocator: std.mem.Allocator, input: put_access_point_policy.PutAccessPointPolicyInput, options: put_access_point_policy.Options) !put_access_point_policy.PutAccessPointPolicyOutput {
        return put_access_point_policy.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Creates or replaces resource policy for an Object Lambda Access Point. For
    /// an example policy, see [Creating Object Lambda Access
    /// Points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/olap-create.html#olap-create-cli) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to
    /// `PutAccessPointPolicyForObjectLambda`:
    ///
    /// *
    ///   [DeleteAccessPointPolicyForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteAccessPointPolicyForObjectLambda.html)
    ///
    /// *
    ///   [GetAccessPointPolicyForObjectLambda](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetAccessPointPolicyForObjectLambda.html)
    pub fn putAccessPointPolicyForObjectLambda(self: *Self, allocator: std.mem.Allocator, input: put_access_point_policy_for_object_lambda.PutAccessPointPolicyForObjectLambdaInput, options: put_access_point_policy_for_object_lambda.Options) !put_access_point_policy_for_object_lambda.PutAccessPointPolicyForObjectLambdaOutput {
        return put_access_point_policy_for_object_lambda.execute(self, allocator, input, options);
    }

    /// Creates or replaces the access point scope for a directory bucket. You can
    /// use the access point scope to restrict access to specific prefixes, API
    /// operations, or a combination of both.
    ///
    /// You can specify any amount of prefixes, but the total length of characters
    /// of all prefixes must be less than 256 bytes in size.
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3express:PutAccessPointScope` action.
    ///
    /// For information about REST API errors, see [REST error
    /// responses](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#RESTErrorResponses).
    pub fn putAccessPointScope(self: *Self, allocator: std.mem.Allocator, input: put_access_point_scope.PutAccessPointScopeInput, options: put_access_point_scope.Options) !put_access_point_scope.PutAccessPointScopeOutput {
        return put_access_point_scope.execute(self, allocator, input, options);
    }

    /// This action puts a lifecycle configuration to an Amazon S3 on Outposts
    /// bucket. To put a
    /// lifecycle configuration to an S3 bucket, see
    /// [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html) in the *Amazon S3 API Reference*.
    ///
    /// Creates a new lifecycle configuration for the S3 on Outposts bucket or
    /// replaces an
    /// existing lifecycle configuration. Outposts buckets only support lifecycle
    /// configurations
    /// that delete/expire objects after a certain period of time and abort
    /// incomplete multipart
    /// uploads.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketLifecycleConfiguration.html#API_control_PutBucketLifecycleConfiguration_Examples) section.
    ///
    /// The following actions are related to
    /// `PutBucketLifecycleConfiguration`:
    ///
    /// *
    ///   [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketLifecycleConfiguration.html)
    ///
    /// *
    ///   [DeleteBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketLifecycleConfiguration.html)
    pub fn putBucketLifecycleConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_bucket_lifecycle_configuration.PutBucketLifecycleConfigurationInput, options: put_bucket_lifecycle_configuration.Options) !put_bucket_lifecycle_configuration.PutBucketLifecycleConfigurationOutput {
        return put_bucket_lifecycle_configuration.execute(self, allocator, input, options);
    }

    /// This action puts a bucket policy to an Amazon S3 on Outposts bucket. To put
    /// a policy on an
    /// S3 bucket, see
    /// [PutBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketPolicy.html) in the
    /// *Amazon S3 API Reference*.
    ///
    /// Applies an Amazon S3 bucket policy to an Outposts bucket. For more
    /// information, see [Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    ///
    /// If you are using an identity other than the root user of the Amazon Web
    /// Services account that owns the
    /// Outposts bucket, the calling identity must have the `PutBucketPolicy`
    /// permissions on the specified Outposts bucket and belong to the bucket
    /// owner's account in
    /// order to use this action.
    ///
    /// If you don't have `PutBucketPolicy` permissions, Amazon S3 returns a `403
    /// Access Denied` error. If you have the correct permissions, but you're not
    /// using an
    /// identity that belongs to the bucket owner's account, Amazon S3 returns a
    /// `405 Method Not
    /// Allowed` error.
    ///
    /// As a security precaution, the root user of the Amazon Web Services account
    /// that owns a bucket can
    /// always use this action, even if the policy explicitly denies the root user
    /// the ability
    /// to perform this action.
    ///
    /// For more information about bucket policies, see [Using Bucket Policies and
    /// User
    /// Policies](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html).
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketPolicy.html#API_control_PutBucketPolicy_Examples) section.
    ///
    /// The following actions are related to `PutBucketPolicy`:
    ///
    /// *
    ///   [GetBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketPolicy.html)
    ///
    /// *
    ///   [DeleteBucketPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketPolicy.html)
    pub fn putBucketPolicy(self: *Self, allocator: std.mem.Allocator, input: put_bucket_policy.PutBucketPolicyInput, options: put_bucket_policy.Options) !put_bucket_policy.PutBucketPolicyOutput {
        return put_bucket_policy.execute(self, allocator, input, options);
    }

    /// This action creates an Amazon S3 on Outposts bucket's replication
    /// configuration. To create
    /// an S3 bucket's replication configuration, see
    /// [PutBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketReplication.html)
    /// in the *Amazon S3 API Reference*.
    ///
    /// Creates a replication configuration or replaces an existing one. For
    /// information about
    /// S3 replication on Outposts configuration, see [Replicating objects for
    /// S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsReplication.html) in the *Amazon S3 User Guide*.
    ///
    /// It can take a while to propagate `PUT` or `DELETE` requests for
    /// a replication configuration to all S3 on Outposts systems. Therefore, the
    /// replication
    /// configuration that's returned by a `GET` request soon after a
    /// `PUT` or `DELETE` request might return a more recent result
    /// than what's on the Outpost. If an Outpost is offline, the delay in updating
    /// the
    /// replication configuration on that Outpost can be significant.
    ///
    /// Specify the replication configuration in the request body. In the
    /// replication
    /// configuration, you provide the following information:
    ///
    /// * The name of the destination bucket or buckets where you want S3 on
    ///   Outposts to
    /// replicate objects
    ///
    /// * The Identity and Access Management (IAM) role that S3 on Outposts can
    ///   assume to replicate objects on
    /// your behalf
    ///
    /// * Other relevant information, such as replication rules
    ///
    /// A replication configuration must include at least one rule and can contain a
    /// maximum of
    /// 100. Each rule identifies a subset of objects to replicate by filtering the
    /// objects in the
    /// source Outposts bucket. To choose additional subsets of objects to
    /// replicate, add a rule
    /// for each subset.
    ///
    /// To specify a subset of the objects in the source Outposts bucket to apply a
    /// replication
    /// rule to, add the `Filter` element as a child of the `Rule` element.
    /// You can filter objects based on an object key prefix, one or more object
    /// tags, or both.
    /// When you add the `Filter` element in the configuration, you must also add
    /// the
    /// following elements: `DeleteMarkerReplication`, `Status`, and
    /// `Priority`.
    ///
    /// Using `PutBucketReplication` on Outposts requires that both the source and
    /// destination buckets must have versioning enabled. For information about
    /// enabling versioning
    /// on a bucket, see [Managing S3 Versioning
    /// for your S3 on Outposts
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsManagingVersioning.html).
    ///
    /// For information about S3 on Outposts replication failure reasons, see
    /// [Replication failure
    /// reasons](https://docs.aws.amazon.com/AmazonS3/latest/userguide/outposts-replication-eventbridge.html#outposts-replication-failure-codes) in the *Amazon S3 User Guide*.
    ///
    /// **Handling Replication of Encrypted Objects**
    ///
    /// Outposts buckets are encrypted at all times. All the objects in the source
    /// Outposts
    /// bucket are encrypted and can be replicated. Also, all the replicas in the
    /// destination
    /// Outposts bucket are encrypted with the same encryption key as the objects in
    /// the source
    /// Outposts bucket.
    ///
    /// **Permissions**
    ///
    /// To create a `PutBucketReplication` request, you must have
    /// `s3-outposts:PutReplicationConfiguration` permissions for the bucket. The
    /// Outposts bucket owner has this permission by default and can grant it to
    /// others. For more
    /// information about permissions, see [Setting up IAM with
    /// S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsIAM.html) and [Managing access to
    /// S3 on Outposts
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsBucketPolicy.html).
    ///
    /// To perform this operation, the user or role must also have the
    /// `iam:CreateRole` and `iam:PassRole` permissions. For more
    /// information, see [Granting a user permissions to
    /// pass a role to an Amazon Web Services
    /// service](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html).
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketReplication.html#API_control_PutBucketReplication_Examples) section.
    ///
    /// The following operations are related to `PutBucketReplication`:
    ///
    /// *
    ///   [GetBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketReplication.html)
    ///
    /// *
    ///   [DeleteBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketReplication.html)
    pub fn putBucketReplication(self: *Self, allocator: std.mem.Allocator, input: put_bucket_replication.PutBucketReplicationInput, options: put_bucket_replication.Options) !put_bucket_replication.PutBucketReplicationOutput {
        return put_bucket_replication.execute(self, allocator, input, options);
    }

    /// This action puts tags on an Amazon S3 on Outposts bucket. To put tags on an
    /// S3 bucket, see
    /// [PutBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketTagging.html) in the *Amazon S3 API Reference*.
    ///
    /// Sets the tags for an S3 on Outposts bucket. For more information, see [Using
    /// Amazon S3 on
    /// Outposts](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    ///
    /// Use tags to organize your Amazon Web Services bill to reflect your own cost
    /// structure. To do this,
    /// sign up to get your Amazon Web Services account bill with tag key values
    /// included. Then, to see the cost
    /// of combined resources, organize your billing information according to
    /// resources with the
    /// same tag key values. For example, you can tag several resources with a
    /// specific application
    /// name, and then organize your billing information to see the total cost of
    /// that application
    /// across several services. For more information, see [Cost allocation and
    /// tagging](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html).
    ///
    /// Within a bucket, if you add a tag that has the same key as an existing tag,
    /// the new
    /// value overwrites the old value. For more information, see [ Using cost
    /// allocation in Amazon S3
    /// bucket
    /// tags](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CostAllocTagging.html).
    ///
    /// To use this action, you must have permissions to perform the
    /// `s3-outposts:PutBucketTagging` action. The Outposts bucket owner has this
    /// permission by default and can grant this permission to others. For more
    /// information about
    /// permissions, see [ Permissions Related to Bucket Subresource
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources) and [Managing
    /// access permissions to your Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html).
    ///
    /// `PutBucketTagging` has the following special errors:
    ///
    /// * Error code: `InvalidTagError`
    ///
    /// * Description: The tag provided was not a valid tag. This error can occur if
    /// the tag did not pass input validation. For information about tag
    /// restrictions,
    /// see [
    /// User-Defined Tag
    /// Restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html) and [
    /// Amazon Web Services-Generated Cost Allocation Tag
    /// Restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/aws-tag-restrictions.html).
    ///
    /// * Error code: `MalformedXMLError`
    ///
    /// * Description: The XML provided does not match the schema.
    ///
    /// * Error code: `OperationAbortedError `
    ///
    /// * Description: A conflicting conditional action is currently in progress
    /// against this resource. Try again.
    ///
    /// * Error code: `InternalError`
    ///
    /// * Description: The service was unable to apply the provided tag to the
    /// bucket.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketTagging.html#API_control_PutBucketTagging_Examples) section.
    ///
    /// The following actions are related to `PutBucketTagging`:
    ///
    /// *
    ///   [GetBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketTagging.html)
    ///
    /// *
    ///   [DeleteBucketTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteBucketTagging.html)
    pub fn putBucketTagging(self: *Self, allocator: std.mem.Allocator, input: put_bucket_tagging.PutBucketTaggingInput, options: put_bucket_tagging.Options) !put_bucket_tagging.PutBucketTaggingOutput {
        return put_bucket_tagging.execute(self, allocator, input, options);
    }

    /// This operation sets the versioning state
    /// for
    /// S3 on Outposts
    /// buckets
    /// only. To set the versioning state for an S3 bucket, see
    /// [PutBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketVersioning.html) in the *Amazon S3 API Reference*.
    ///
    /// Sets the versioning state for an S3 on Outposts bucket. With
    /// S3
    /// Versioning,
    /// you can save multiple distinct copies of your
    /// objects
    /// and recover from unintended user actions and application failures.
    ///
    /// You can set the versioning state to one of the following:
    ///
    /// * **Enabled** - Enables versioning for the objects in
    /// the bucket. All objects added to the bucket receive a unique version ID.
    ///
    /// * **Suspended** - Suspends versioning for the objects
    /// in the bucket. All objects added to the bucket receive the version ID
    /// `null`.
    ///
    /// If you've never set versioning on your bucket, it has no versioning state.
    /// In that case,
    /// a [
    /// GetBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketVersioning.html) request does not return a versioning state value.
    ///
    /// When you enable S3 Versioning, for each object in your bucket, you have a
    /// current
    /// version and zero or more noncurrent versions. You can configure your bucket
    /// S3 Lifecycle
    /// rules to expire noncurrent versions after a specified time period. For more
    /// information,
    /// see [ Creating and managing
    /// a lifecycle configuration for your S3 on Outposts
    /// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsLifecycleManaging.html) in the *Amazon S3
    /// User Guide*.
    ///
    /// If you have an object expiration lifecycle configuration in your
    /// non-versioned bucket
    /// and you want to maintain the same permanent delete behavior when you enable
    /// versioning, you
    /// must add a noncurrent expiration policy. The noncurrent expiration lifecycle
    /// configuration
    /// will manage the deletes of the noncurrent object versions in the
    /// version-enabled bucket.
    /// For more information, see
    /// [Versioning](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Versioning.html) in the *Amazon S3
    /// User Guide*.
    ///
    /// All Amazon S3 on Outposts REST API requests for this action require an
    /// additional parameter of `x-amz-outpost-id` to be passed with the request. In
    /// addition, you must use an S3 on Outposts endpoint hostname prefix instead of
    /// `s3-control`. For an example of the request syntax for Amazon S3 on Outposts
    /// that uses the S3 on Outposts endpoint hostname prefix and the
    /// `x-amz-outpost-id` derived by using the access point ARN, see the
    /// [Examples](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketVersioning.html#API_control_PutBucketVersioning_Examples) section.
    ///
    /// The following operations are related to `PutBucketVersioning` for
    /// S3 on Outposts.
    ///
    /// *
    ///   [GetBucketVersioning](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketVersioning.html)
    ///
    /// *
    ///   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutBucketLifecycleConfiguration.html)
    ///
    /// *
    ///   [GetBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetBucketLifecycleConfiguration.html)
    pub fn putBucketVersioning(self: *Self, allocator: std.mem.Allocator, input: put_bucket_versioning.PutBucketVersioningInput, options: put_bucket_versioning.Options) !put_bucket_versioning.PutBucketVersioningOutput {
        return put_bucket_versioning.execute(self, allocator, input, options);
    }

    /// Sets the supplied tag-set on an S3 Batch Operations job.
    ///
    /// A tag is a key-value pair. You can associate S3 Batch Operations tags with
    /// any job by sending
    /// a PUT request against the tagging subresource that is associated with the
    /// job. To modify
    /// the existing tag set, you can either replace the existing tag set entirely,
    /// or make changes
    /// within the existing tag set by retrieving the existing tag set using
    /// [GetJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetJobTagging.html), modify that tag set, and use this operation to replace the tag set
    /// with the one you modified. For more information, see [Controlling
    /// access and labeling jobs using
    /// tags](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-managing-jobs.html#batch-ops-job-tags) in the *Amazon S3 User Guide*.
    ///
    /// * If you send this request with an empty tag set, Amazon S3 deletes the
    ///   existing
    /// tag set on the Batch Operations job. If you use this method, you are charged
    /// for a Tier
    /// 1 Request (PUT). For more information, see [Amazon S3
    /// pricing](http://aws.amazon.com/s3/pricing/).
    ///
    /// * For deleting existing tags for your Batch Operations job, a
    ///   [DeleteJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteJobTagging.html) request is preferred because it achieves the same
    /// result without incurring charges.
    ///
    /// * A few things to consider about using tags:
    ///
    /// * Amazon S3 limits the maximum number of tags to 50 tags per job.
    ///
    /// * You can associate up to 50 tags with a job as long as they have unique
    /// tag keys.
    ///
    /// * A tag key can be up to 128 Unicode characters in length, and tag values
    /// can be up to 256 Unicode characters in length.
    ///
    /// * The key and values are case sensitive.
    ///
    /// * For tagging-related restrictions related to characters and encodings, see
    /// [User-Defined Tag
    /// Restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html) in the *Billing and Cost Management User Guide*.
    ///
    /// **Permissions**
    ///
    /// To use the
    /// `PutJobTagging` operation, you must have permission to
    /// perform the `s3:PutJobTagging` action.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateJob.html)
    ///
    /// *
    ///   [GetJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetJobTagging.html)
    ///
    /// *
    ///   [DeleteJobTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteJobTagging.html)
    pub fn putJobTagging(self: *Self, allocator: std.mem.Allocator, input: put_job_tagging.PutJobTaggingInput, options: put_job_tagging.Options) !put_job_tagging.PutJobTaggingOutput {
        return put_job_tagging.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Associates an access control policy with the specified Multi-Region Access
    /// Point. Each Multi-Region Access Point can have only
    /// one policy, so a request made to this action replaces any existing policy
    /// that is
    /// associated with the specified Multi-Region Access Point.
    ///
    /// This action will always be routed to the US West (Oregon) Region. For more
    /// information
    /// about the restrictions around working with Multi-Region Access Points, see
    /// [Multi-Region Access Point
    /// restrictions and
    /// limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/MultiRegionAccessPointRestrictions.html) in the *Amazon S3 User Guide*.
    ///
    /// The following actions are related to
    /// `PutMultiRegionAccessPointPolicy`:
    ///
    /// *
    ///   [GetMultiRegionAccessPointPolicy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPointPolicy.html)
    ///
    /// *
    ///   [GetMultiRegionAccessPointPolicyStatus](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetMultiRegionAccessPointPolicyStatus.html)
    pub fn putMultiRegionAccessPointPolicy(self: *Self, allocator: std.mem.Allocator, input: put_multi_region_access_point_policy.PutMultiRegionAccessPointPolicyInput, options: put_multi_region_access_point_policy.Options) !put_multi_region_access_point_policy.PutMultiRegionAccessPointPolicyOutput {
        return put_multi_region_access_point_policy.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Creates or modifies the `PublicAccessBlock` configuration for an
    /// Amazon Web Services account. This operation may be restricted when the
    /// account is managed by
    /// organization-level Block Public Access policies. You might get an Access
    /// Denied (403) error
    /// when the account is managed by organization-level Block Public Access
    /// policies.
    /// Organization-level policies override account-level settings, preventing
    /// direct
    /// account-level modifications. For this operation, users must have the
    /// `s3:PutAccountPublicAccessBlock` permission. For more information, see [
    /// Using Amazon S3 block public
    /// access](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html).
    ///
    /// Related actions include:
    ///
    /// *
    ///   [GetPublicAccessBlock](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_GetPublicAccessBlock.html)
    ///
    /// *
    ///   [DeletePublicAccessBlock](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeletePublicAccessBlock.html)
    pub fn putPublicAccessBlock(self: *Self, allocator: std.mem.Allocator, input: put_public_access_block.PutPublicAccessBlockInput, options: put_public_access_block.Options) !put_public_access_block.PutPublicAccessBlockOutput {
        return put_public_access_block.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Puts an Amazon S3 Storage Lens configuration. For more information about S3
    /// Storage Lens, see [Working with
    /// Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens.html) in
    /// the *Amazon S3 User Guide*. For a complete list of S3 Storage Lens metrics,
    /// see [S3 Storage Lens metrics
    /// glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html) in the *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3:PutStorageLensConfiguration` action. For more information, see [Setting
    /// permissions to use Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens_iam_permissions.html) in the
    /// *Amazon S3 User Guide*.
    pub fn putStorageLensConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_storage_lens_configuration.PutStorageLensConfigurationInput, options: put_storage_lens_configuration.Options) !put_storage_lens_configuration.PutStorageLensConfigurationOutput {
        return put_storage_lens_configuration.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Put or replace tags on an existing Amazon S3 Storage Lens configuration. For
    /// more information
    /// about S3 Storage Lens, see [Assessing your storage activity and usage with
    /// Amazon S3 Storage Lens
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// To use this action, you must have permission to perform the
    /// `s3:PutStorageLensConfigurationTagging` action. For more information, see
    /// [Setting permissions to
    /// use Amazon S3 Storage
    /// Lens](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage_lens_iam_permissions.html) in the *Amazon S3 User Guide*.
    pub fn putStorageLensConfigurationTagging(self: *Self, allocator: std.mem.Allocator, input: put_storage_lens_configuration_tagging.PutStorageLensConfigurationTaggingInput, options: put_storage_lens_configuration_tagging.Options) !put_storage_lens_configuration_tagging.PutStorageLensConfigurationTaggingOutput {
        return put_storage_lens_configuration_tagging.execute(self, allocator, input, options);
    }

    /// This operation is not supported by directory buckets.
    ///
    /// Submits an updated route configuration for a Multi-Region Access Point. This
    /// API operation updates the
    /// routing status for the specified Regions from active to passive, or from
    /// passive to active.
    /// A value of `0` indicates a passive status, which means that traffic won't be
    /// routed to the specified Region. A value of `100` indicates an active status,
    /// which means that traffic will be routed to the specified Region. At least
    /// one Region must
    /// be active at all times.
    ///
    /// When the routing configuration is changed, any in-progress operations
    /// (uploads, copies,
    /// deletes, and so on) to formerly active Regions will continue to run to their
    /// final
    /// completion state (success or failure). The routing configurations of any
    /// Regions that
    /// aren’t specified remain unchanged.
    ///
    /// Updated routing configurations might not be immediately applied. It can take
    /// up to 2
    /// minutes for your changes to take effect.
    ///
    /// To submit routing control changes and failover requests, use the Amazon S3
    /// failover control
    /// infrastructure endpoints in these five Amazon Web Services Regions:
    ///
    /// * `us-east-1`
    ///
    /// * `us-west-2`
    ///
    /// * `ap-southeast-2`
    ///
    /// * `ap-northeast-1`
    ///
    /// * `eu-west-1`
    pub fn submitMultiRegionAccessPointRoutes(self: *Self, allocator: std.mem.Allocator, input: submit_multi_region_access_point_routes.SubmitMultiRegionAccessPointRoutesInput, options: submit_multi_region_access_point_routes.Options) !submit_multi_region_access_point_routes.SubmitMultiRegionAccessPointRoutesOutput {
        return submit_multi_region_access_point_routes.execute(self, allocator, input, options);
    }

    /// Creates a new user-defined tag or updates an existing tag. Each tag is a
    /// label consisting of a key and value that is applied to your resource. Tags
    /// can help you organize, track costs for, and control access to your
    /// resources. You can add up to 50 Amazon Web Services resource tags for each
    /// S3 resource.
    ///
    /// This operation is only supported for the following Amazon S3 resource:
    ///
    /// * [General purpose
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/buckets-tagging.html)
    ///
    /// * [Access Points for directory
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-db-tagging.html)
    ///
    /// * [Access Points for general purpose
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-tagging.html)
    ///
    /// * [Directory
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-tagging.html)
    ///
    /// * [S3 Storage Lens
    ///   groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-lens-groups.html)
    ///
    /// * [S3 Access Grants instances, registered locations, or
    ///   grants](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-grants-tagging.html).
    ///
    /// **Permissions**
    ///
    /// For general purpose buckets, access points for general purpose buckets,
    /// Storage Lens groups, and S3 Access Grants, you must have the
    /// `s3:TagResource` permission to use this operation.
    ///
    /// **Directory bucket permissions**
    ///
    /// For directory buckets, you must have the `s3express:TagResource` permission
    /// to use this operation. For more information about directory buckets policies
    /// and permissions, see [Identity and Access Management (IAM) for S3 Express
    /// One
    /// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-permissions.html) in the *Amazon S3 User Guide*.
    ///
    /// **HTTP Host header syntax**
    ///
    /// **Directory buckets ** - The HTTP Host header syntax is
    /// `s3express-control.*region*.amazonaws.com`.
    ///
    /// For information about S3 Tagging errors, see [List of Amazon S3 Tagging
    /// error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3TaggingErrorCodeList).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// This operation removes the specified user-defined tags from an S3 resource.
    /// You can pass one or more tag keys.
    ///
    /// This operation is only supported for the following Amazon S3 resources:
    ///
    /// * [General purpose
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/buckets-tagging.html)
    ///
    /// * [Access Points for directory
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-db-tagging.html)
    ///
    /// * [Access Points for general purpose
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-tagging.html)
    ///
    /// * [Directory
    ///   buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-tagging.html)
    ///
    /// * [S3 Storage Lens
    ///   groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-lens-groups.html)
    ///
    /// * [S3 Access Grants instances, registered locations, and
    ///   grants](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-grants-tagging.html).
    ///
    /// **Permissions**
    ///
    /// For general purpose buckets, access points for general purpose buckets,
    /// Storage Lens groups, and S3 Access Grants, you must have the
    /// `s3:UntagResource` permission to use this operation.
    ///
    /// **Directory bucket permissions**
    ///
    /// For directory buckets, you must have the `s3express:UntagResource`
    /// permission to use this operation. For more information about directory
    /// buckets policies and permissions, see [Identity and Access Management (IAM)
    /// for S3 Express One
    /// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-permissions.html) in the *Amazon S3 User Guide*.
    ///
    /// **HTTP Host header syntax**
    ///
    /// **Directory buckets ** - The HTTP Host header syntax is
    /// `s3express-control.*region*.amazonaws.com`.
    ///
    /// For information about S3 Tagging errors, see [List of Amazon S3
    /// Tagging error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3TaggingErrorCodeList).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the IAM role of a registered location in your S3 Access Grants
    /// instance.
    ///
    /// **Permissions**
    ///
    /// You must have the `s3:UpdateAccessGrantsLocation` permission to use this
    /// operation.
    ///
    /// **Additional Permissions**
    ///
    /// You must also have the following permission: `iam:PassRole`
    pub fn updateAccessGrantsLocation(self: *Self, allocator: std.mem.Allocator, input: update_access_grants_location.UpdateAccessGrantsLocationInput, options: update_access_grants_location.Options) !update_access_grants_location.UpdateAccessGrantsLocationOutput {
        return update_access_grants_location.execute(self, allocator, input, options);
    }

    /// Updates an existing S3 Batch Operations job's priority. For more
    /// information, see [S3 Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/batch-ops.html) in the *Amazon S3 User Guide*.
    ///
    /// **Permissions**
    ///
    /// To use the
    /// `UpdateJobPriority` operation, you must have permission to
    /// perform the `s3:UpdateJobPriority` action.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateJob.html)
    ///
    /// *
    ///   [ListJobs](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListJobs.html)
    ///
    /// *
    ///   [DescribeJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeJob.html)
    ///
    /// *
    ///   [UpdateJobStatus](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobStatus.html)
    pub fn updateJobPriority(self: *Self, allocator: std.mem.Allocator, input: update_job_priority.UpdateJobPriorityInput, options: update_job_priority.Options) !update_job_priority.UpdateJobPriorityOutput {
        return update_job_priority.execute(self, allocator, input, options);
    }

    /// Updates the status for the specified job. Use this operation to confirm that
    /// you want to
    /// run a job or to cancel an existing job. For more information, see [S3 Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/batch-ops.html) in the *Amazon S3 User Guide*.
    ///
    /// **Permissions**
    ///
    /// To use the
    /// `UpdateJobStatus` operation, you must have permission to
    /// perform the `s3:UpdateJobStatus` action.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateJob.html)
    ///
    /// *
    ///   [ListJobs](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_ListJobs.html)
    ///
    /// *
    ///   [DescribeJob](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DescribeJob.html)
    ///
    /// *
    ///   [UpdateJobStatus](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_UpdateJobStatus.html)
    pub fn updateJobStatus(self: *Self, allocator: std.mem.Allocator, input: update_job_status.UpdateJobStatusInput, options: update_job_status.Options) !update_job_status.UpdateJobStatusOutput {
        return update_job_status.execute(self, allocator, input, options);
    }

    /// Updates the existing Storage Lens group.
    ///
    /// To use this operation, you must have the permission to perform the
    /// `s3:UpdateStorageLensGroup` action. For more information about the required
    /// Storage Lens
    /// Groups permissions, see [Setting account permissions to use S3 Storage Lens
    /// groups](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_iam_permissions.html#storage_lens_groups_permissions).
    ///
    /// For information about Storage Lens groups errors, see [List of Amazon S3
    /// Storage
    /// Lens error
    /// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#S3LensErrorCodeList).
    pub fn updateStorageLensGroup(self: *Self, allocator: std.mem.Allocator, input: update_storage_lens_group.UpdateStorageLensGroupInput, options: update_storage_lens_group.Options) !update_storage_lens_group.UpdateStorageLensGroupOutput {
        return update_storage_lens_group.execute(self, allocator, input, options);
    }

    pub fn listAccessGrantsPaginator(self: *Self, params: list_access_grants.ListAccessGrantsInput) paginator.ListAccessGrantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessGrantsInstancesPaginator(self: *Self, params: list_access_grants_instances.ListAccessGrantsInstancesInput) paginator.ListAccessGrantsInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessGrantsLocationsPaginator(self: *Self, params: list_access_grants_locations.ListAccessGrantsLocationsInput) paginator.ListAccessGrantsLocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessPointsPaginator(self: *Self, params: list_access_points.ListAccessPointsInput) paginator.ListAccessPointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessPointsForDirectoryBucketsPaginator(self: *Self, params: list_access_points_for_directory_buckets.ListAccessPointsForDirectoryBucketsInput) paginator.ListAccessPointsForDirectoryBucketsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessPointsForObjectLambdaPaginator(self: *Self, params: list_access_points_for_object_lambda.ListAccessPointsForObjectLambdaInput) paginator.ListAccessPointsForObjectLambdaPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCallerAccessGrantsPaginator(self: *Self, params: list_caller_access_grants.ListCallerAccessGrantsInput) paginator.ListCallerAccessGrantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMultiRegionAccessPointsPaginator(self: *Self, params: list_multi_region_access_points.ListMultiRegionAccessPointsInput) paginator.ListMultiRegionAccessPointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRegionalBucketsPaginator(self: *Self, params: list_regional_buckets.ListRegionalBucketsInput) paginator.ListRegionalBucketsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStorageLensConfigurationsPaginator(self: *Self, params: list_storage_lens_configurations.ListStorageLensConfigurationsInput) paginator.ListStorageLensConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStorageLensGroupsPaginator(self: *Self, params: list_storage_lens_groups.ListStorageLensGroupsInput) paginator.ListStorageLensGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
