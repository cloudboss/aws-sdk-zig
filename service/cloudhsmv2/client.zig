const aws = @import("aws");
const std = @import("std");

const copy_backup_to_region = @import("copy_backup_to_region.zig");
const create_cluster = @import("create_cluster.zig");
const create_hsm = @import("create_hsm.zig");
const delete_backup = @import("delete_backup.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_hsm = @import("delete_hsm.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const describe_backups = @import("describe_backups.zig");
const describe_clusters = @import("describe_clusters.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const initialize_cluster = @import("initialize_cluster.zig");
const list_tags = @import("list_tags.zig");
const modify_backup_attributes = @import("modify_backup_attributes.zig");
const modify_cluster = @import("modify_cluster.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const restore_backup = @import("restore_backup.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudHSM V2";

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

    /// Copy an CloudHSM cluster backup to a different region.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// backup in a different Amazon Web Services account.
    pub fn copyBackupToRegion(self: *Self, allocator: std.mem.Allocator, input: copy_backup_to_region.CopyBackupToRegionInput, options: CallOptions) !copy_backup_to_region.CopyBackupToRegionOutput {
        return copy_backup_to_region.execute(self, allocator, input, options);
    }

    /// Creates a new CloudHSM cluster.
    ///
    /// **Cross-account use:** Yes. To perform this operation with an CloudHSM
    /// backup in a different AWS account, specify the full backup
    /// ARN in the value of the SourceBackupId parameter.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: CallOptions) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new hardware security module (HSM) in the specified CloudHSM
    /// cluster.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// cluster in a different Amazon Web Service account.
    pub fn createHsm(self: *Self, allocator: std.mem.Allocator, input: create_hsm.CreateHsmInput, options: CallOptions) !create_hsm.CreateHsmOutput {
        return create_hsm.execute(self, allocator, input, options);
    }

    /// Deletes a specified CloudHSM backup. A backup can be restored up to 7 days
    /// after the DeleteBackup request is made. For more information on restoring a
    /// backup, see
    /// RestoreBackup.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// backup in a different Amazon Web Services account.
    pub fn deleteBackup(self: *Self, allocator: std.mem.Allocator, input: delete_backup.DeleteBackupInput, options: CallOptions) !delete_backup.DeleteBackupOutput {
        return delete_backup.execute(self, allocator, input, options);
    }

    /// Deletes the specified CloudHSM cluster. Before you can delete a cluster, you
    /// must
    /// delete all HSMs in the cluster. To see if the cluster contains any HSMs, use
    /// DescribeClusters. To delete an HSM, use DeleteHsm.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// cluster in a different Amazon Web Services account.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: CallOptions) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified HSM. To specify an HSM, you can use its identifier
    /// (ID), the IP
    /// address of the HSM's elastic network interface (ENI), or the ID of the HSM's
    /// ENI. You need to
    /// specify only one of these values. To find these values, use
    /// DescribeClusters.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// hsm in a different Amazon Web Services account.
    pub fn deleteHsm(self: *Self, allocator: std.mem.Allocator, input: delete_hsm.DeleteHsmInput, options: CallOptions) !delete_hsm.DeleteHsmOutput {
        return delete_hsm.execute(self, allocator, input, options);
    }

    /// Deletes an CloudHSM resource policy. Deleting a resource policy will result
    /// in the resource being unshared and removed from
    /// any RAM resource shares. Deleting the resource policy attached to a backup
    /// will not impact any clusters created from that
    /// backup.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// resource in a different Amazon Web Services account.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Gets information about backups of CloudHSM clusters. Lists either the
    /// backups you own or the backups shared with you when the Shared parameter is
    /// true.
    ///
    /// This is a paginated operation, which means that each response might contain
    /// only a
    /// subset of all the backups. When the response contains only a subset of
    /// backups, it includes a
    /// `NextToken` value. Use this value in a subsequent `DescribeBackups`
    /// request to get more backups. When you receive a response with no `NextToken`
    /// (or an
    /// empty or null value), that means there are no more backups to get.
    ///
    /// **Cross-account use:** Yes. Customers can describe backups in other Amazon
    /// Web Services accounts that are shared with them.
    pub fn describeBackups(self: *Self, allocator: std.mem.Allocator, input: describe_backups.DescribeBackupsInput, options: CallOptions) !describe_backups.DescribeBackupsOutput {
        return describe_backups.execute(self, allocator, input, options);
    }

    /// Gets information about CloudHSM clusters.
    ///
    /// This is a paginated operation, which means that each response might contain
    /// only a
    /// subset of all the clusters. When the response contains only a subset of
    /// clusters, it includes
    /// a `NextToken` value. Use this value in a subsequent `DescribeClusters`
    /// request to get more clusters. When you receive a response with no
    /// `NextToken` (or
    /// an empty or null value), that means there are no more clusters to get.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on CloudHSM
    /// clusters in a different Amazon Web Services account.
    pub fn describeClusters(self: *Self, allocator: std.mem.Allocator, input: describe_clusters.DescribeClustersInput, options: CallOptions) !describe_clusters.DescribeClustersOutput {
        return describe_clusters.execute(self, allocator, input, options);
    }

    /// Retrieves the resource policy document attached to a given resource.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// resource in a different Amazon Web Services account.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Claims an CloudHSM cluster by submitting the cluster certificate issued by
    /// your
    /// issuing certificate authority (CA) and the CA's root certificate. Before you
    /// can claim a
    /// cluster, you must sign the cluster's certificate signing request (CSR) with
    /// your issuing CA.
    /// To get the cluster's CSR, use DescribeClusters.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// cluster in a different Amazon Web Services account.
    pub fn initializeCluster(self: *Self, allocator: std.mem.Allocator, input: initialize_cluster.InitializeClusterInput, options: CallOptions) !initialize_cluster.InitializeClusterOutput {
        return initialize_cluster.execute(self, allocator, input, options);
    }

    /// Gets a list of tags for the specified CloudHSM cluster.
    ///
    /// This is a paginated operation, which means that each response might contain
    /// only a
    /// subset of all the tags. When the response contains only a subset of tags, it
    /// includes a
    /// `NextToken` value. Use this value in a subsequent `ListTags` request to
    /// get more tags. When you receive a response with no `NextToken` (or an empty
    /// or null
    /// value), that means there are no more tags to get.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// resource in a different Amazon Web Services account.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: CallOptions) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Modifies attributes for CloudHSM backup.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// backup in a different Amazon Web Services account.
    pub fn modifyBackupAttributes(self: *Self, allocator: std.mem.Allocator, input: modify_backup_attributes.ModifyBackupAttributesInput, options: CallOptions) !modify_backup_attributes.ModifyBackupAttributesOutput {
        return modify_backup_attributes.execute(self, allocator, input, options);
    }

    /// Modifies CloudHSM cluster.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// cluster in a different Amazon Web Services account.
    pub fn modifyCluster(self: *Self, allocator: std.mem.Allocator, input: modify_cluster.ModifyClusterInput, options: CallOptions) !modify_cluster.ModifyClusterOutput {
        return modify_cluster.execute(self, allocator, input, options);
    }

    /// Creates or updates an CloudHSM resource policy. A resource policy helps you
    /// to define the IAM entity
    /// (for example, an Amazon Web Services account) that can manage your CloudHSM
    /// resources. The following resources support
    /// CloudHSM resource policies:
    ///
    /// * Backup - The resource policy allows you to describe the backup and restore
    ///   a cluster from the backup in another Amazon Web Services account.
    ///
    /// In order to share a backup, it must be in a 'READY' state and you must own
    /// it.
    ///
    /// While you can share a backup using the CloudHSM PutResourcePolicy operation,
    /// we recommend using Resource Access Manager
    /// (RAM) instead. Using RAM provides multiple benefits as it creates the policy
    /// for you, allows multiple resources to be shared at
    /// one time, and increases the discoverability of shared resources. If you use
    /// PutResourcePolicy and want consumers to be able to
    /// describe the backups you share with them, you must promote the backup to a
    /// standard RAM
    /// Resource Share using the RAM PromoteResourceShareCreatedFromPolicy API
    /// operation.
    ///
    /// For more information, see [ Working with shared
    /// backups](https://docs.aws.amazon.com/cloudhsm/latest/userguide/sharing.html)
    /// in the CloudHSM User Guide
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// resource in a different Amazon Web Services account.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Restores a specified CloudHSM backup that is in the
    /// `PENDING_DELETION` state. For more information on deleting a backup, see
    /// DeleteBackup.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// backup in a different Amazon Web Services account.
    pub fn restoreBackup(self: *Self, allocator: std.mem.Allocator, input: restore_backup.RestoreBackupInput, options: CallOptions) !restore_backup.RestoreBackupOutput {
        return restore_backup.execute(self, allocator, input, options);
    }

    /// Adds or overwrites one or more tags for the specified CloudHSM cluster.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// resource in a different Amazon Web Services account.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tag or tags from the specified CloudHSM cluster.
    ///
    /// **Cross-account use:** No. You cannot perform this operation on an CloudHSM
    /// resource in a different Amazon Web Services account.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn describeBackupsPaginator(self: *Self, params: describe_backups.DescribeBackupsInput) paginator.DescribeBackupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeClustersPaginator(self: *Self, params: describe_clusters.DescribeClustersInput) paginator.DescribeClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsPaginator(self: *Self, params: list_tags.ListTagsInput) paginator.ListTagsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
