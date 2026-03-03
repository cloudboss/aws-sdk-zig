const aws = @import("aws");
const std = @import("std");

const associate_resource = @import("associate_resource.zig");
const create_canary = @import("create_canary.zig");
const create_group = @import("create_group.zig");
const delete_canary = @import("delete_canary.zig");
const delete_group = @import("delete_group.zig");
const describe_canaries = @import("describe_canaries.zig");
const describe_canaries_last_run = @import("describe_canaries_last_run.zig");
const describe_runtime_versions = @import("describe_runtime_versions.zig");
const disassociate_resource = @import("disassociate_resource.zig");
const get_canary = @import("get_canary.zig");
const get_canary_runs = @import("get_canary_runs.zig");
const get_group = @import("get_group.zig");
const list_associated_groups = @import("list_associated_groups.zig");
const list_group_resources = @import("list_group_resources.zig");
const list_groups = @import("list_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_canary = @import("start_canary.zig");
const start_canary_dry_run = @import("start_canary_dry_run.zig");
const stop_canary = @import("stop_canary.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_canary = @import("update_canary.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "synthetics";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates a canary with a group. Using groups can help you with
    /// managing and automating your canaries, and you can also view aggregated run
    /// results and statistics
    /// for all canaries in a group.
    ///
    /// You must run this operation in the Region where the canary exists.
    pub fn associateResource(self: *Self, allocator: std.mem.Allocator, input: associate_resource.AssociateResourceInput, options: associate_resource.Options) !associate_resource.AssociateResourceOutput {
        return associate_resource.execute(self, allocator, input, options);
    }

    /// Creates a canary. Canaries are scripts that monitor your endpoints and APIs
    /// from the
    /// outside-in. Canaries help you check the availability and latency of your web
    /// services and
    /// troubleshoot anomalies by investigating load time data, screenshots of the
    /// UI, logs, and
    /// metrics. You can set up a canary to run continuously or just once.
    ///
    /// Do not use `CreateCanary` to modify an existing canary. Use
    /// [UpdateCanary](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_UpdateCanary.html) instead.
    ///
    /// To create canaries, you must have the `CloudWatchSyntheticsFullAccess`
    /// policy.
    /// If you are creating a new IAM role for the canary, you also need the
    /// `iam:CreateRole`, `iam:CreatePolicy` and
    /// `iam:AttachRolePolicy` permissions. For more information, see [Necessary
    /// Roles and
    /// Permissions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Roles).
    ///
    /// Do not include secrets or proprietary information in your canary names. The
    /// canary name
    /// makes up part of the Amazon Resource Name (ARN) for the canary, and the ARN
    /// is included in
    /// outbound calls over the internet. For more information, see [Security
    /// Considerations for Synthetics
    /// Canaries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/servicelens_canaries_security.html).
    pub fn createCanary(self: *Self, allocator: std.mem.Allocator, input: create_canary.CreateCanaryInput, options: create_canary.Options) !create_canary.CreateCanaryOutput {
        return create_canary.execute(self, allocator, input, options);
    }

    /// Creates a group which you can use to associate canaries with each other,
    /// including cross-Region
    /// canaries. Using groups can help you with
    /// managing and automating your canaries, and you can also view aggregated run
    /// results and statistics
    /// for all canaries in a group.
    ///
    /// Groups are global resources. When you create a group, it is replicated
    /// across Amazon Web Services Regions, and
    /// you can view it and add canaries to it from any Region.
    /// Although the group ARN format reflects the Region name where it was created,
    /// a group is not constrained to any Region.
    /// This means that you can put canaries from multiple Regions into the same
    /// group, and then use
    /// that group to view and manage all of those canaries in a single view.
    ///
    /// Groups are supported in all Regions except the Regions that are disabled by
    /// default. For more information
    /// about these Regions, see [Enabling a
    /// Region](https://docs.aws.amazon.com/general/latest/gr/rande-manage.html#rande-manage-enable).
    ///
    /// Each group can contain as many as 10 canaries. You can have as many as 20
    /// groups in your account. Any single canary
    /// can be a member of up to 10 groups.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: create_group.Options) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Permanently deletes the specified canary.
    ///
    /// If the canary's `ProvisionedResourceCleanup` field is set to `AUTOMATIC`
    /// or you specify `DeleteLambda` in this operation as `true`, CloudWatch
    /// Synthetics also deletes
    /// the Lambda functions and layers that are used by the canary.
    ///
    /// Other resources used and created by the canary are not automatically
    /// deleted.
    /// After you delete a canary, you
    /// should also delete the following:
    ///
    /// * The CloudWatch alarms created for this canary. These alarms have a name of
    /// `Synthetics-Alarm-*first-198-characters-of-canary-name*-*canaryId*-*alarm
    /// number*
    /// `
    ///
    /// * Amazon S3 objects and buckets, such as the canary's artifact location.
    ///
    /// * IAM roles created for the canary. If they were created in the console,
    ///   these roles
    /// have the name `
    /// role/service-role/CloudWatchSyntheticsRole-*First-21-Characters-of-CanaryName*
    /// `
    ///
    /// * CloudWatch Logs log groups created for the canary. These logs groups have
    ///   the name
    /// `/aws/lambda/cwsyn-*First-21-Characters-of-CanaryName*
    /// `
    ///
    /// Before you delete a canary, you might want to use `GetCanary` to display
    /// the information about this canary. Make
    /// note of the information returned by this operation so that you can delete
    /// these resources
    /// after you delete the canary.
    pub fn deleteCanary(self: *Self, allocator: std.mem.Allocator, input: delete_canary.DeleteCanaryInput, options: delete_canary.Options) !delete_canary.DeleteCanaryOutput {
        return delete_canary.execute(self, allocator, input, options);
    }

    /// Deletes a group. The group doesn't need to be empty to be deleted. If there
    /// are canaries in the group,
    /// they are not deleted when you delete the group.
    ///
    /// Groups are a global resource that appear in all Regions, but the request to
    /// delete a group
    /// must be made from its home Region. You can find the home Region of a group
    /// within its ARN.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: delete_group.Options) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// This operation returns a list of the canaries in your account, along with
    /// full details
    /// about each canary.
    ///
    /// This operation supports resource-level authorization using an IAM policy and
    /// the `Names` parameter. If you specify the `Names` parameter, the operation
    /// is successful only if you have authorization to view
    /// all the canaries that you specify in your request. If you do not have
    /// permission to view any of
    /// the canaries, the request fails with a 403 response.
    ///
    /// You are required to use the `Names` parameter if you are logged on to a user
    /// or role that has an
    /// IAM policy that restricts which canaries that you are allowed to view. For
    /// more information,
    /// see [
    /// Limiting a user to viewing specific
    /// canaries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Restricted.html).
    pub fn describeCanaries(self: *Self, allocator: std.mem.Allocator, input: describe_canaries.DescribeCanariesInput, options: describe_canaries.Options) !describe_canaries.DescribeCanariesOutput {
        return describe_canaries.execute(self, allocator, input, options);
    }

    /// Use this operation to see information from the most recent run of each
    /// canary that you have created.
    ///
    /// This operation supports resource-level authorization using an IAM policy and
    /// the `Names` parameter. If you specify the `Names` parameter, the operation
    /// is successful only if you have authorization to view
    /// all the canaries that you specify in your request. If you do not have
    /// permission to view any of
    /// the canaries, the request fails with a 403 response.
    ///
    /// You are required to use the `Names` parameter if you are logged on to a user
    /// or role that has an
    /// IAM policy that restricts which canaries that you are allowed to view. For
    /// more information,
    /// see [
    /// Limiting a user to viewing specific
    /// canaries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Restricted.html).
    pub fn describeCanariesLastRun(self: *Self, allocator: std.mem.Allocator, input: describe_canaries_last_run.DescribeCanariesLastRunInput, options: describe_canaries_last_run.Options) !describe_canaries_last_run.DescribeCanariesLastRunOutput {
        return describe_canaries_last_run.execute(self, allocator, input, options);
    }

    /// Returns a list of Synthetics canary runtime versions. For more information,
    /// see [
    /// Canary Runtime
    /// Versions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Library.html).
    pub fn describeRuntimeVersions(self: *Self, allocator: std.mem.Allocator, input: describe_runtime_versions.DescribeRuntimeVersionsInput, options: describe_runtime_versions.Options) !describe_runtime_versions.DescribeRuntimeVersionsOutput {
        return describe_runtime_versions.execute(self, allocator, input, options);
    }

    /// Removes a canary from a group. You must run this operation in the Region
    /// where the canary exists.
    pub fn disassociateResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_resource.DisassociateResourceInput, options: disassociate_resource.Options) !disassociate_resource.DisassociateResourceOutput {
        return disassociate_resource.execute(self, allocator, input, options);
    }

    /// Retrieves complete information about one canary. You must specify
    /// the name of the canary that you want. To get a list of canaries
    /// and their names, use
    /// [DescribeCanaries](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_DescribeCanaries.html).
    pub fn getCanary(self: *Self, allocator: std.mem.Allocator, input: get_canary.GetCanaryInput, options: get_canary.Options) !get_canary.GetCanaryOutput {
        return get_canary.execute(self, allocator, input, options);
    }

    /// Retrieves a list of runs for a specified canary.
    pub fn getCanaryRuns(self: *Self, allocator: std.mem.Allocator, input: get_canary_runs.GetCanaryRunsInput, options: get_canary_runs.Options) !get_canary_runs.GetCanaryRunsOutput {
        return get_canary_runs.execute(self, allocator, input, options);
    }

    /// Returns information about one group. Groups are a global resource, so you
    /// can use this operation from
    /// any Region.
    pub fn getGroup(self: *Self, allocator: std.mem.Allocator, input: get_group.GetGroupInput, options: get_group.Options) !get_group.GetGroupOutput {
        return get_group.execute(self, allocator, input, options);
    }

    /// Returns a list of the groups that the specified canary is associated with.
    /// The canary
    /// that you specify must be in the current Region.
    pub fn listAssociatedGroups(self: *Self, allocator: std.mem.Allocator, input: list_associated_groups.ListAssociatedGroupsInput, options: list_associated_groups.Options) !list_associated_groups.ListAssociatedGroupsOutput {
        return list_associated_groups.execute(self, allocator, input, options);
    }

    /// This operation returns a list of the ARNs of the canaries that are
    /// associated with the specified group.
    pub fn listGroupResources(self: *Self, allocator: std.mem.Allocator, input: list_group_resources.ListGroupResourcesInput, options: list_group_resources.Options) !list_group_resources.ListGroupResourcesOutput {
        return list_group_resources.execute(self, allocator, input, options);
    }

    /// Returns a list of all groups in the account, displaying their names, unique
    /// IDs, and ARNs. The groups
    /// from all Regions are returned.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: list_groups.Options) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a canary or group.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Use this operation to run a canary that has already been created.
    /// The frequency of the canary runs is determined by the value of the canary's
    /// `Schedule`. To see a canary's schedule,
    /// use
    /// [GetCanary](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_GetCanary.html).
    pub fn startCanary(self: *Self, allocator: std.mem.Allocator, input: start_canary.StartCanaryInput, options: start_canary.Options) !start_canary.StartCanaryOutput {
        return start_canary.execute(self, allocator, input, options);
    }

    /// Use this operation to start a dry run for a canary that has already been
    /// created
    pub fn startCanaryDryRun(self: *Self, allocator: std.mem.Allocator, input: start_canary_dry_run.StartCanaryDryRunInput, options: start_canary_dry_run.Options) !start_canary_dry_run.StartCanaryDryRunOutput {
        return start_canary_dry_run.execute(self, allocator, input, options);
    }

    /// Stops the canary to prevent all future runs. If the canary is currently
    /// running,the
    /// run that is in progress completes on its own, publishes metrics, and uploads
    /// artifacts, but
    /// it is not recorded in Synthetics as a completed run.
    ///
    /// You can use `StartCanary` to start it running again
    /// with the canary’s current schedule at any point in the future.
    pub fn stopCanary(self: *Self, allocator: std.mem.Allocator, input: stop_canary.StopCanaryInput, options: stop_canary.Options) !stop_canary.StopCanaryOutput {
        return stop_canary.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified canary or group.
    ///
    /// Tags can help you organize and categorize your
    /// resources. You can also use them to scope user permissions, by granting a
    /// user permission to access or change only resources with
    /// certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can use the `TagResource` action with a resource that already has tags.
    /// If you specify a new
    /// tag key for the resource,
    /// this tag is appended to the list of tags associated
    /// with the resource. If you specify a tag key that is already associated with
    /// the resource, the new tag
    /// value that you specify replaces
    /// the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a canary or group.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a canary that has already been created.
    ///
    /// For multibrowser canaries, you can add or remove browsers by updating the
    /// browserConfig list in the update call. For example:
    ///
    /// * To add Firefox to a canary that currently uses Chrome, specify
    ///   browserConfigs as [CHROME, FIREFOX]
    ///
    /// * To remove Firefox and keep only Chrome, specify browserConfigs as [CHROME]
    ///
    /// You can't use this operation to update the tags of an existing canary. To
    /// change the tags of an existing canary, use
    /// [TagResource](https://docs.aws.amazon.com/AmazonSynthetics/latest/APIReference/API_TagResource.html).
    ///
    /// When you use the `dryRunId` field when updating a canary, the only other
    /// field you can provide is the `Schedule`. Adding any other field will thrown
    /// an exception.
    pub fn updateCanary(self: *Self, allocator: std.mem.Allocator, input: update_canary.UpdateCanaryInput, options: update_canary.Options) !update_canary.UpdateCanaryOutput {
        return update_canary.execute(self, allocator, input, options);
    }

    pub fn describeCanariesPaginator(self: *Self, params: describe_canaries.DescribeCanariesInput) paginator.DescribeCanariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCanariesLastRunPaginator(self: *Self, params: describe_canaries_last_run.DescribeCanariesLastRunInput) paginator.DescribeCanariesLastRunPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRuntimeVersionsPaginator(self: *Self, params: describe_runtime_versions.DescribeRuntimeVersionsInput) paginator.DescribeRuntimeVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCanaryRunsPaginator(self: *Self, params: get_canary_runs.GetCanaryRunsInput) paginator.GetCanaryRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociatedGroupsPaginator(self: *Self, params: list_associated_groups.ListAssociatedGroupsInput) paginator.ListAssociatedGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupResourcesPaginator(self: *Self, params: list_group_resources.ListGroupResourcesInput) paginator.ListGroupResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupsPaginator(self: *Self, params: list_groups.ListGroupsInput) paginator.ListGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
