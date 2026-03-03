const aws = @import("aws");
const std = @import("std");

const cancel_tag_sync_task = @import("cancel_tag_sync_task.zig");
const create_group = @import("create_group.zig");
const delete_group = @import("delete_group.zig");
const get_account_settings = @import("get_account_settings.zig");
const get_group = @import("get_group.zig");
const get_group_configuration = @import("get_group_configuration.zig");
const get_group_query = @import("get_group_query.zig");
const get_tag_sync_task = @import("get_tag_sync_task.zig");
const get_tags = @import("get_tags.zig");
const group_resources = @import("group_resources.zig");
const list_group_resources = @import("list_group_resources.zig");
const list_grouping_statuses = @import("list_grouping_statuses.zig");
const list_groups = @import("list_groups.zig");
const list_tag_sync_tasks = @import("list_tag_sync_tasks.zig");
const put_group_configuration = @import("put_group_configuration.zig");
const search_resources = @import("search_resources.zig");
const start_tag_sync_task = @import("start_tag_sync_task.zig");
const tag_ = @import("tag.zig");
const ungroup_resources = @import("ungroup_resources.zig");
const untag_ = @import("untag.zig");
const update_account_settings = @import("update_account_settings.zig");
const update_group = @import("update_group.zig");
const update_group_query = @import("update_group_query.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Resource Groups";

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

    /// Cancels the specified tag-sync task.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:CancelTagSyncTask` on the application group
    ///
    /// * `resource-groups:DeleteGroup`
    pub fn cancelTagSyncTask(self: *Self, allocator: std.mem.Allocator, input: cancel_tag_sync_task.CancelTagSyncTaskInput, options: cancel_tag_sync_task.Options) !cancel_tag_sync_task.CancelTagSyncTaskOutput {
        return cancel_tag_sync_task.execute(self, allocator, input, options);
    }

    /// Creates a resource group with the specified name and description. You can
    /// optionally
    /// include either a resource query or a service configuration. For more
    /// information about
    /// constructing a resource query, see [Build queries and groups in
    /// Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/userguide/getting_started-query.html) in the *Resource Groups User Guide*. For more information
    /// about service-linked groups and service configurations, see [Service
    /// configurations for Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:CreateGroup`
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: create_group.Options) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource group. Deleting a resource group does not
    /// delete any
    /// resources that are members of the group; it only deletes the group
    /// structure.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:DeleteGroup`
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: delete_group.Options) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Retrieves the current status of optional features in Resource Groups.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: get_account_settings.Options) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Returns information about a specified resource group.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:GetGroup`
    pub fn getGroup(self: *Self, allocator: std.mem.Allocator, input: get_group.GetGroupInput, options: get_group.Options) !get_group.GetGroupOutput {
        return get_group.execute(self, allocator, input, options);
    }

    /// Retrieves the service configuration associated with the specified resource
    /// group. For
    /// details about the service configuration syntax, see [Service configurations
    /// for Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:GetGroupConfiguration`
    pub fn getGroupConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_group_configuration.GetGroupConfigurationInput, options: get_group_configuration.Options) !get_group_configuration.GetGroupConfigurationOutput {
        return get_group_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the resource query associated with the specified resource group.
    /// For more
    /// information about resource queries, see [Create
    /// a tag-based group in Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted-query.html#gettingstarted-query-cli-tag).
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:GetGroupQuery`
    pub fn getGroupQuery(self: *Self, allocator: std.mem.Allocator, input: get_group_query.GetGroupQueryInput, options: get_group_query.Options) !get_group_query.GetGroupQueryOutput {
        return get_group_query.execute(self, allocator, input, options);
    }

    /// Returns information about a specified tag-sync task.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:GetTagSyncTask` on the application group
    pub fn getTagSyncTask(self: *Self, allocator: std.mem.Allocator, input: get_tag_sync_task.GetTagSyncTaskInput, options: get_tag_sync_task.Options) !get_tag_sync_task.GetTagSyncTaskOutput {
        return get_tag_sync_task.execute(self, allocator, input, options);
    }

    /// Returns a list of tags that are associated with a resource group, specified
    /// by an
    /// Amazon resource name (ARN).
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:GetTags`
    pub fn getTags(self: *Self, allocator: std.mem.Allocator, input: get_tags.GetTagsInput, options: get_tags.Options) !get_tags.GetTagsOutput {
        return get_tags.execute(self, allocator, input, options);
    }

    /// Adds the specified resources to the specified group.
    ///
    /// You can only use this operation with the following groups:
    ///
    /// * `AWS::EC2::HostManagement`
    ///
    /// * `AWS::EC2::CapacityReservationPool`
    ///
    /// * `AWS::ResourceGroups::ApplicationGroup`
    ///
    /// Other resource group types and resource types are not currently supported by
    /// this
    /// operation.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:GroupResources`
    pub fn groupResources(self: *Self, allocator: std.mem.Allocator, input: group_resources.GroupResourcesInput, options: group_resources.Options) !group_resources.GroupResourcesOutput {
        return group_resources.execute(self, allocator, input, options);
    }

    /// Returns a list of Amazon resource names (ARNs) of the resources that are
    /// members of a specified resource
    /// group.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:ListGroupResources`
    ///
    /// * `cloudformation:DescribeStacks`
    ///
    /// * `cloudformation:ListStackResources`
    ///
    /// * `tag:GetResources`
    pub fn listGroupResources(self: *Self, allocator: std.mem.Allocator, input: list_group_resources.ListGroupResourcesInput, options: list_group_resources.Options) !list_group_resources.ListGroupResourcesOutput {
        return list_group_resources.execute(self, allocator, input, options);
    }

    /// Returns the status of the last grouping or ungrouping action for
    /// each resource in the specified application group.
    pub fn listGroupingStatuses(self: *Self, allocator: std.mem.Allocator, input: list_grouping_statuses.ListGroupingStatusesInput, options: list_grouping_statuses.Options) !list_grouping_statuses.ListGroupingStatusesOutput {
        return list_grouping_statuses.execute(self, allocator, input, options);
    }

    /// Returns a list of existing Resource Groups in your account.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:ListGroups`
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: list_groups.Options) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of tag-sync tasks.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:ListTagSyncTasks` with the group passed in the filters as
    ///   the resource
    /// or * if using no filters
    pub fn listTagSyncTasks(self: *Self, allocator: std.mem.Allocator, input: list_tag_sync_tasks.ListTagSyncTasksInput, options: list_tag_sync_tasks.Options) !list_tag_sync_tasks.ListTagSyncTasksOutput {
        return list_tag_sync_tasks.execute(self, allocator, input, options);
    }

    /// Attaches a service configuration to the specified group. This occurs
    /// asynchronously,
    /// and can take time to complete. You can use GetGroupConfiguration to
    /// check the status of the update.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:PutGroupConfiguration`
    pub fn putGroupConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_group_configuration.PutGroupConfigurationInput, options: put_group_configuration.Options) !put_group_configuration.PutGroupConfigurationOutput {
        return put_group_configuration.execute(self, allocator, input, options);
    }

    /// Returns a list of Amazon Web Services resource identifiers that matches the
    /// specified query. The
    /// query uses the same format as a resource query in a CreateGroup or
    /// UpdateGroupQuery operation.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:SearchResources`
    ///
    /// * `cloudformation:DescribeStacks`
    ///
    /// * `cloudformation:ListStackResources`
    ///
    /// * `tag:GetResources`
    pub fn searchResources(self: *Self, allocator: std.mem.Allocator, input: search_resources.SearchResourcesInput, options: search_resources.Options) !search_resources.SearchResourcesOutput {
        return search_resources.execute(self, allocator, input, options);
    }

    /// Creates a new tag-sync task to onboard and sync resources tagged with a
    /// specific tag key-value pair to an
    /// application. To start a tag-sync task, you need a [resource tagging
    /// role](https://docs.aws.amazon.com/servicecatalog/latest/arguide/app-tag-sync.html#tag-sync-role).
    /// The resource tagging role grants permissions to tag and untag applications
    /// resources and must include a
    /// trust policy that allows Resource Groups to assume the role and perform
    /// resource tagging tasks on your behalf.
    ///
    /// For instructions on creating a tag-sync task, see [Create a tag-sync
    /// using the Resource Groups
    /// API](https://docs.aws.amazon.com/servicecatalog/latest/arguide/app-tag-sync.html#create-tag-sync) in the *Amazon Web Services Service Catalog AppRegistry Administrator Guide*.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:StartTagSyncTask` on the application group
    ///
    /// * `resource-groups:CreateGroup`
    ///
    /// * `iam:PassRole` on the role provided in the request
    pub fn startTagSyncTask(self: *Self, allocator: std.mem.Allocator, input: start_tag_sync_task.StartTagSyncTaskInput, options: start_tag_sync_task.Options) !start_tag_sync_task.StartTagSyncTaskOutput {
        return start_tag_sync_task.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource group with the specified Amazon resource name (ARN).
    /// Existing tags on a resource
    /// group are not changed if they are not specified in the request parameters.
    ///
    /// Do not store personally identifiable information (PII) or other confidential
    /// or
    /// sensitive information in tags. We use tags to provide you with billing and
    /// administration services. Tags are not intended to be used for private or
    /// sensitive
    /// data.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:Tag`
    pub fn tag(self: *Self, allocator: std.mem.Allocator, input: tag_.TagInput, options: tag_.Options) !tag_.TagOutput {
        return tag_.execute(self, allocator, input, options);
    }

    /// Removes the specified resources from the specified group. This operation
    /// works only
    /// with static groups that you populated using the GroupResources
    /// operation. It doesn't work with any resource groups that are automatically
    /// populated by
    /// tag-based or CloudFormation stack-based queries.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:UngroupResources`
    pub fn ungroupResources(self: *Self, allocator: std.mem.Allocator, input: ungroup_resources.UngroupResourcesInput, options: ungroup_resources.Options) !ungroup_resources.UngroupResourcesOutput {
        return ungroup_resources.execute(self, allocator, input, options);
    }

    /// Deletes tags from a specified resource group.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:Untag`
    pub fn untag(self: *Self, allocator: std.mem.Allocator, input: untag_.UntagInput, options: untag_.Options) !untag_.UntagOutput {
        return untag_.execute(self, allocator, input, options);
    }

    /// Turns on or turns off optional features in Resource Groups.
    ///
    /// The preceding example shows that the request to turn on group lifecycle
    /// events is
    /// `IN_PROGRESS`. You can call the GetAccountSettings
    /// operation to check for completion by looking for
    /// `GroupLifecycleEventsStatus`
    /// to change to `ACTIVE`.
    pub fn updateAccountSettings(self: *Self, allocator: std.mem.Allocator, input: update_account_settings.UpdateAccountSettingsInput, options: update_account_settings.Options) !update_account_settings.UpdateAccountSettingsOutput {
        return update_account_settings.execute(self, allocator, input, options);
    }

    /// Updates the description for an existing group. You cannot update the name of
    /// a
    /// resource group.
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:UpdateGroup`
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: update_group.Options) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Updates the resource query of a group. For more information about resource
    /// queries,
    /// see [Create a tag-based group in Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/userguide/gettingstarted-query.html#gettingstarted-query-cli-tag).
    ///
    /// **Minimum permissions**
    ///
    /// To run this command, you must have the following permissions:
    ///
    /// * `resource-groups:UpdateGroupQuery`
    pub fn updateGroupQuery(self: *Self, allocator: std.mem.Allocator, input: update_group_query.UpdateGroupQueryInput, options: update_group_query.Options) !update_group_query.UpdateGroupQueryOutput {
        return update_group_query.execute(self, allocator, input, options);
    }

    pub fn listGroupResourcesPaginator(self: *Self, params: list_group_resources.ListGroupResourcesInput) paginator.ListGroupResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupingStatusesPaginator(self: *Self, params: list_grouping_statuses.ListGroupingStatusesInput) paginator.ListGroupingStatusesPaginator {
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

    pub fn listTagSyncTasksPaginator(self: *Self, params: list_tag_sync_tasks.ListTagSyncTasksInput) paginator.ListTagSyncTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchResourcesPaginator(self: *Self, params: search_resources.SearchResourcesInput) paginator.SearchResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
