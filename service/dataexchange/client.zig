const aws = @import("aws");
const std = @import("std");

const accept_data_grant = @import("accept_data_grant.zig");
const cancel_job = @import("cancel_job.zig");
const create_data_grant = @import("create_data_grant.zig");
const create_data_set = @import("create_data_set.zig");
const create_event_action = @import("create_event_action.zig");
const create_job = @import("create_job.zig");
const create_revision = @import("create_revision.zig");
const delete_asset = @import("delete_asset.zig");
const delete_data_grant = @import("delete_data_grant.zig");
const delete_data_set = @import("delete_data_set.zig");
const delete_event_action = @import("delete_event_action.zig");
const delete_revision = @import("delete_revision.zig");
const get_asset = @import("get_asset.zig");
const get_data_grant = @import("get_data_grant.zig");
const get_data_set = @import("get_data_set.zig");
const get_event_action = @import("get_event_action.zig");
const get_job = @import("get_job.zig");
const get_received_data_grant = @import("get_received_data_grant.zig");
const get_revision = @import("get_revision.zig");
const list_data_grants = @import("list_data_grants.zig");
const list_data_set_revisions = @import("list_data_set_revisions.zig");
const list_data_sets = @import("list_data_sets.zig");
const list_event_actions = @import("list_event_actions.zig");
const list_jobs = @import("list_jobs.zig");
const list_received_data_grants = @import("list_received_data_grants.zig");
const list_revision_assets = @import("list_revision_assets.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const revoke_revision = @import("revoke_revision.zig");
const send_api_asset = @import("send_api_asset.zig");
const send_data_set_notification = @import("send_data_set_notification.zig");
const start_job = @import("start_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_asset = @import("update_asset.zig");
const update_data_set = @import("update_data_set.zig");
const update_event_action = @import("update_event_action.zig");
const update_revision = @import("update_revision.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DataExchange";

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

    /// This operation accepts a data grant.
    pub fn acceptDataGrant(self: *Self, allocator: std.mem.Allocator, input: accept_data_grant.AcceptDataGrantInput, options: accept_data_grant.Options) !accept_data_grant.AcceptDataGrantOutput {
        return accept_data_grant.execute(self, allocator, input, options);
    }

    /// This operation cancels a job. Jobs can be cancelled only when they are in
    /// the WAITING
    /// state.
    pub fn cancelJob(self: *Self, allocator: std.mem.Allocator, input: cancel_job.CancelJobInput, options: cancel_job.Options) !cancel_job.CancelJobOutput {
        return cancel_job.execute(self, allocator, input, options);
    }

    /// This operation creates a data grant.
    pub fn createDataGrant(self: *Self, allocator: std.mem.Allocator, input: create_data_grant.CreateDataGrantInput, options: create_data_grant.Options) !create_data_grant.CreateDataGrantOutput {
        return create_data_grant.execute(self, allocator, input, options);
    }

    /// This operation creates a data set.
    pub fn createDataSet(self: *Self, allocator: std.mem.Allocator, input: create_data_set.CreateDataSetInput, options: create_data_set.Options) !create_data_set.CreateDataSetOutput {
        return create_data_set.execute(self, allocator, input, options);
    }

    /// This operation creates an event action.
    pub fn createEventAction(self: *Self, allocator: std.mem.Allocator, input: create_event_action.CreateEventActionInput, options: create_event_action.Options) !create_event_action.CreateEventActionOutput {
        return create_event_action.execute(self, allocator, input, options);
    }

    /// This operation creates a job.
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: create_job.Options) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// This operation creates a revision for a data set.
    pub fn createRevision(self: *Self, allocator: std.mem.Allocator, input: create_revision.CreateRevisionInput, options: create_revision.Options) !create_revision.CreateRevisionOutput {
        return create_revision.execute(self, allocator, input, options);
    }

    /// This operation deletes an asset.
    pub fn deleteAsset(self: *Self, allocator: std.mem.Allocator, input: delete_asset.DeleteAssetInput, options: delete_asset.Options) !delete_asset.DeleteAssetOutput {
        return delete_asset.execute(self, allocator, input, options);
    }

    /// This operation deletes a data grant.
    pub fn deleteDataGrant(self: *Self, allocator: std.mem.Allocator, input: delete_data_grant.DeleteDataGrantInput, options: delete_data_grant.Options) !delete_data_grant.DeleteDataGrantOutput {
        return delete_data_grant.execute(self, allocator, input, options);
    }

    /// This operation deletes a data set.
    pub fn deleteDataSet(self: *Self, allocator: std.mem.Allocator, input: delete_data_set.DeleteDataSetInput, options: delete_data_set.Options) !delete_data_set.DeleteDataSetOutput {
        return delete_data_set.execute(self, allocator, input, options);
    }

    /// This operation deletes the event action.
    pub fn deleteEventAction(self: *Self, allocator: std.mem.Allocator, input: delete_event_action.DeleteEventActionInput, options: delete_event_action.Options) !delete_event_action.DeleteEventActionOutput {
        return delete_event_action.execute(self, allocator, input, options);
    }

    /// This operation deletes a revision.
    pub fn deleteRevision(self: *Self, allocator: std.mem.Allocator, input: delete_revision.DeleteRevisionInput, options: delete_revision.Options) !delete_revision.DeleteRevisionOutput {
        return delete_revision.execute(self, allocator, input, options);
    }

    /// This operation returns information about an asset.
    pub fn getAsset(self: *Self, allocator: std.mem.Allocator, input: get_asset.GetAssetInput, options: get_asset.Options) !get_asset.GetAssetOutput {
        return get_asset.execute(self, allocator, input, options);
    }

    /// This operation returns information about a data grant.
    pub fn getDataGrant(self: *Self, allocator: std.mem.Allocator, input: get_data_grant.GetDataGrantInput, options: get_data_grant.Options) !get_data_grant.GetDataGrantOutput {
        return get_data_grant.execute(self, allocator, input, options);
    }

    /// This operation returns information about a data set.
    pub fn getDataSet(self: *Self, allocator: std.mem.Allocator, input: get_data_set.GetDataSetInput, options: get_data_set.Options) !get_data_set.GetDataSetOutput {
        return get_data_set.execute(self, allocator, input, options);
    }

    /// This operation retrieves information about an event action.
    pub fn getEventAction(self: *Self, allocator: std.mem.Allocator, input: get_event_action.GetEventActionInput, options: get_event_action.Options) !get_event_action.GetEventActionOutput {
        return get_event_action.execute(self, allocator, input, options);
    }

    /// This operation returns information about a job.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: get_job.Options) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// This operation returns information about a received data grant.
    pub fn getReceivedDataGrant(self: *Self, allocator: std.mem.Allocator, input: get_received_data_grant.GetReceivedDataGrantInput, options: get_received_data_grant.Options) !get_received_data_grant.GetReceivedDataGrantOutput {
        return get_received_data_grant.execute(self, allocator, input, options);
    }

    /// This operation returns information about a revision.
    pub fn getRevision(self: *Self, allocator: std.mem.Allocator, input: get_revision.GetRevisionInput, options: get_revision.Options) !get_revision.GetRevisionOutput {
        return get_revision.execute(self, allocator, input, options);
    }

    /// This operation returns information about all data grants.
    pub fn listDataGrants(self: *Self, allocator: std.mem.Allocator, input: list_data_grants.ListDataGrantsInput, options: list_data_grants.Options) !list_data_grants.ListDataGrantsOutput {
        return list_data_grants.execute(self, allocator, input, options);
    }

    /// This operation lists a data set's revisions sorted by CreatedAt in
    /// descending
    /// order.
    pub fn listDataSetRevisions(self: *Self, allocator: std.mem.Allocator, input: list_data_set_revisions.ListDataSetRevisionsInput, options: list_data_set_revisions.Options) !list_data_set_revisions.ListDataSetRevisionsOutput {
        return list_data_set_revisions.execute(self, allocator, input, options);
    }

    /// This operation lists your data sets. When listing by origin OWNED, results
    /// are sorted by
    /// CreatedAt in descending order. When listing by origin ENTITLED, there is no
    /// order.
    pub fn listDataSets(self: *Self, allocator: std.mem.Allocator, input: list_data_sets.ListDataSetsInput, options: list_data_sets.Options) !list_data_sets.ListDataSetsOutput {
        return list_data_sets.execute(self, allocator, input, options);
    }

    /// This operation lists your event actions.
    pub fn listEventActions(self: *Self, allocator: std.mem.Allocator, input: list_event_actions.ListEventActionsInput, options: list_event_actions.Options) !list_event_actions.ListEventActionsOutput {
        return list_event_actions.execute(self, allocator, input, options);
    }

    /// This operation lists your jobs sorted by CreatedAt in descending order.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: list_jobs.Options) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// This operation returns information about all received data grants.
    pub fn listReceivedDataGrants(self: *Self, allocator: std.mem.Allocator, input: list_received_data_grants.ListReceivedDataGrantsInput, options: list_received_data_grants.Options) !list_received_data_grants.ListReceivedDataGrantsOutput {
        return list_received_data_grants.execute(self, allocator, input, options);
    }

    /// This operation lists a revision's assets sorted alphabetically in descending
    /// order.
    pub fn listRevisionAssets(self: *Self, allocator: std.mem.Allocator, input: list_revision_assets.ListRevisionAssetsInput, options: list_revision_assets.Options) !list_revision_assets.ListRevisionAssetsOutput {
        return list_revision_assets.execute(self, allocator, input, options);
    }

    /// This operation lists the tags on the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// This operation revokes subscribers' access to a revision.
    pub fn revokeRevision(self: *Self, allocator: std.mem.Allocator, input: revoke_revision.RevokeRevisionInput, options: revoke_revision.Options) !revoke_revision.RevokeRevisionOutput {
        return revoke_revision.execute(self, allocator, input, options);
    }

    /// This operation invokes an API Gateway API asset. The request is proxied to
    /// the
    /// provider’s API Gateway API.
    pub fn sendApiAsset(self: *Self, allocator: std.mem.Allocator, input: send_api_asset.SendApiAssetInput, options: send_api_asset.Options) !send_api_asset.SendApiAssetOutput {
        return send_api_asset.execute(self, allocator, input, options);
    }

    /// The type of event associated with the data set.
    pub fn sendDataSetNotification(self: *Self, allocator: std.mem.Allocator, input: send_data_set_notification.SendDataSetNotificationInput, options: send_data_set_notification.Options) !send_data_set_notification.SendDataSetNotificationOutput {
        return send_data_set_notification.execute(self, allocator, input, options);
    }

    /// This operation starts a job.
    pub fn startJob(self: *Self, allocator: std.mem.Allocator, input: start_job.StartJobInput, options: start_job.Options) !start_job.StartJobOutput {
        return start_job.execute(self, allocator, input, options);
    }

    /// This operation tags a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// This operation removes one or more tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// This operation updates an asset.
    pub fn updateAsset(self: *Self, allocator: std.mem.Allocator, input: update_asset.UpdateAssetInput, options: update_asset.Options) !update_asset.UpdateAssetOutput {
        return update_asset.execute(self, allocator, input, options);
    }

    /// This operation updates a data set.
    pub fn updateDataSet(self: *Self, allocator: std.mem.Allocator, input: update_data_set.UpdateDataSetInput, options: update_data_set.Options) !update_data_set.UpdateDataSetOutput {
        return update_data_set.execute(self, allocator, input, options);
    }

    /// This operation updates the event action.
    pub fn updateEventAction(self: *Self, allocator: std.mem.Allocator, input: update_event_action.UpdateEventActionInput, options: update_event_action.Options) !update_event_action.UpdateEventActionOutput {
        return update_event_action.execute(self, allocator, input, options);
    }

    /// This operation updates a revision.
    pub fn updateRevision(self: *Self, allocator: std.mem.Allocator, input: update_revision.UpdateRevisionInput, options: update_revision.Options) !update_revision.UpdateRevisionOutput {
        return update_revision.execute(self, allocator, input, options);
    }

    pub fn listDataGrantsPaginator(self: *Self, params: list_data_grants.ListDataGrantsInput) paginator.ListDataGrantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSetRevisionsPaginator(self: *Self, params: list_data_set_revisions.ListDataSetRevisionsInput) paginator.ListDataSetRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSetsPaginator(self: *Self, params: list_data_sets.ListDataSetsInput) paginator.ListDataSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventActionsPaginator(self: *Self, params: list_event_actions.ListEventActionsInput) paginator.ListEventActionsPaginator {
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

    pub fn listReceivedDataGrantsPaginator(self: *Self, params: list_received_data_grants.ListReceivedDataGrantsInput) paginator.ListReceivedDataGrantsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRevisionAssetsPaginator(self: *Self, params: list_revision_assets.ListRevisionAssetsInput) paginator.ListRevisionAssetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
