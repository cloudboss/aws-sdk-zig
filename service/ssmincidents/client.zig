const aws = @import("aws");
const std = @import("std");

const batch_get_incident_findings = @import("batch_get_incident_findings.zig");
const create_replication_set = @import("create_replication_set.zig");
const create_response_plan = @import("create_response_plan.zig");
const create_timeline_event = @import("create_timeline_event.zig");
const delete_incident_record = @import("delete_incident_record.zig");
const delete_replication_set = @import("delete_replication_set.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_response_plan = @import("delete_response_plan.zig");
const delete_timeline_event = @import("delete_timeline_event.zig");
const get_incident_record = @import("get_incident_record.zig");
const get_replication_set = @import("get_replication_set.zig");
const get_resource_policies = @import("get_resource_policies.zig");
const get_response_plan = @import("get_response_plan.zig");
const get_timeline_event = @import("get_timeline_event.zig");
const list_incident_findings = @import("list_incident_findings.zig");
const list_incident_records = @import("list_incident_records.zig");
const list_related_items = @import("list_related_items.zig");
const list_replication_sets = @import("list_replication_sets.zig");
const list_response_plans = @import("list_response_plans.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_timeline_events = @import("list_timeline_events.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const start_incident = @import("start_incident.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_deletion_protection = @import("update_deletion_protection.zig");
const update_incident_record = @import("update_incident_record.zig");
const update_related_items = @import("update_related_items.zig");
const update_replication_set = @import("update_replication_set.zig");
const update_response_plan = @import("update_response_plan.zig");
const update_timeline_event = @import("update_timeline_event.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSM Incidents";

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

    /// Retrieves details about all specified findings for an incident, including
    /// descriptive details about each finding. A finding
    /// represents a recent application environment change made by an CodeDeploy
    /// deployment or an CloudFormation stack creation or update that can be
    /// investigated as a
    /// potential cause of the incident.
    pub fn batchGetIncidentFindings(self: *Self, allocator: std.mem.Allocator, input: batch_get_incident_findings.BatchGetIncidentFindingsInput, options: CallOptions) !batch_get_incident_findings.BatchGetIncidentFindingsOutput {
        return batch_get_incident_findings.execute(self, allocator, input, options);
    }

    /// A replication set replicates and encrypts your data to the provided Regions
    /// with the
    /// provided KMS key.
    pub fn createReplicationSet(self: *Self, allocator: std.mem.Allocator, input: create_replication_set.CreateReplicationSetInput, options: CallOptions) !create_replication_set.CreateReplicationSetOutput {
        return create_replication_set.execute(self, allocator, input, options);
    }

    /// Creates a response plan that automates the initial response to incidents. A
    /// response plan
    /// engages contacts, starts chat channel collaboration, and initiates runbooks
    /// at the beginning
    /// of an incident.
    pub fn createResponsePlan(self: *Self, allocator: std.mem.Allocator, input: create_response_plan.CreateResponsePlanInput, options: CallOptions) !create_response_plan.CreateResponsePlanOutput {
        return create_response_plan.execute(self, allocator, input, options);
    }

    /// Creates a custom timeline event on the incident details page of an incident
    /// record.
    /// Incident Manager automatically creates timeline events that mark key moments
    /// during an incident.
    /// You can create custom timeline events to mark important events that Incident
    /// Manager can detect
    /// automatically.
    pub fn createTimelineEvent(self: *Self, allocator: std.mem.Allocator, input: create_timeline_event.CreateTimelineEventInput, options: CallOptions) !create_timeline_event.CreateTimelineEventOutput {
        return create_timeline_event.execute(self, allocator, input, options);
    }

    /// Delete an incident record from Incident Manager.
    pub fn deleteIncidentRecord(self: *Self, allocator: std.mem.Allocator, input: delete_incident_record.DeleteIncidentRecordInput, options: CallOptions) !delete_incident_record.DeleteIncidentRecordOutput {
        return delete_incident_record.execute(self, allocator, input, options);
    }

    /// Deletes all Regions in your replication set. Deleting the replication set
    /// deletes all
    /// Incident Manager data.
    pub fn deleteReplicationSet(self: *Self, allocator: std.mem.Allocator, input: delete_replication_set.DeleteReplicationSetInput, options: CallOptions) !delete_replication_set.DeleteReplicationSetOutput {
        return delete_replication_set.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy that Resource Access Manager uses to share your
    /// Incident Manager
    /// resource.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified response plan. Deleting a response plan stops all
    /// linked CloudWatch alarms and EventBridge events from creating an incident
    /// with this response
    /// plan.
    pub fn deleteResponsePlan(self: *Self, allocator: std.mem.Allocator, input: delete_response_plan.DeleteResponsePlanInput, options: CallOptions) !delete_response_plan.DeleteResponsePlanOutput {
        return delete_response_plan.execute(self, allocator, input, options);
    }

    /// Deletes a timeline event from an incident.
    pub fn deleteTimelineEvent(self: *Self, allocator: std.mem.Allocator, input: delete_timeline_event.DeleteTimelineEventInput, options: CallOptions) !delete_timeline_event.DeleteTimelineEventOutput {
        return delete_timeline_event.execute(self, allocator, input, options);
    }

    /// Returns the details for the specified incident record.
    pub fn getIncidentRecord(self: *Self, allocator: std.mem.Allocator, input: get_incident_record.GetIncidentRecordInput, options: CallOptions) !get_incident_record.GetIncidentRecordOutput {
        return get_incident_record.execute(self, allocator, input, options);
    }

    /// Retrieve your Incident Manager replication set.
    pub fn getReplicationSet(self: *Self, allocator: std.mem.Allocator, input: get_replication_set.GetReplicationSetInput, options: CallOptions) !get_replication_set.GetReplicationSetOutput {
        return get_replication_set.execute(self, allocator, input, options);
    }

    /// Retrieves the resource policies attached to the specified response plan.
    pub fn getResourcePolicies(self: *Self, allocator: std.mem.Allocator, input: get_resource_policies.GetResourcePoliciesInput, options: CallOptions) !get_resource_policies.GetResourcePoliciesOutput {
        return get_resource_policies.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified response plan.
    pub fn getResponsePlan(self: *Self, allocator: std.mem.Allocator, input: get_response_plan.GetResponsePlanInput, options: CallOptions) !get_response_plan.GetResponsePlanOutput {
        return get_response_plan.execute(self, allocator, input, options);
    }

    /// Retrieves a timeline event based on its ID and incident record.
    pub fn getTimelineEvent(self: *Self, allocator: std.mem.Allocator, input: get_timeline_event.GetTimelineEventInput, options: CallOptions) !get_timeline_event.GetTimelineEventOutput {
        return get_timeline_event.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the IDs of findings, plus their last modified times,
    /// that have been
    /// identified for a specified incident. A finding represents a recent
    /// application environment
    /// change made by an CloudFormation stack creation or update or an CodeDeploy
    /// deployment that can be investigated as a potential cause of the incident.
    pub fn listIncidentFindings(self: *Self, allocator: std.mem.Allocator, input: list_incident_findings.ListIncidentFindingsInput, options: CallOptions) !list_incident_findings.ListIncidentFindingsOutput {
        return list_incident_findings.execute(self, allocator, input, options);
    }

    /// Lists all incident records in your account. Use this command to retrieve the
    /// Amazon
    /// Resource Name (ARN) of the incident record you want to update.
    pub fn listIncidentRecords(self: *Self, allocator: std.mem.Allocator, input: list_incident_records.ListIncidentRecordsInput, options: CallOptions) !list_incident_records.ListIncidentRecordsOutput {
        return list_incident_records.execute(self, allocator, input, options);
    }

    /// List all related items for an incident record.
    pub fn listRelatedItems(self: *Self, allocator: std.mem.Allocator, input: list_related_items.ListRelatedItemsInput, options: CallOptions) !list_related_items.ListRelatedItemsOutput {
        return list_related_items.execute(self, allocator, input, options);
    }

    /// Lists details about the replication set configured in your account.
    pub fn listReplicationSets(self: *Self, allocator: std.mem.Allocator, input: list_replication_sets.ListReplicationSetsInput, options: CallOptions) !list_replication_sets.ListReplicationSetsOutput {
        return list_replication_sets.execute(self, allocator, input, options);
    }

    /// Lists all response plans in your account.
    pub fn listResponsePlans(self: *Self, allocator: std.mem.Allocator, input: list_response_plans.ListResponsePlansInput, options: CallOptions) !list_response_plans.ListResponsePlansOutput {
        return list_response_plans.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified response plan or incident.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists timeline events for the specified incident record.
    pub fn listTimelineEvents(self: *Self, allocator: std.mem.Allocator, input: list_timeline_events.ListTimelineEventsInput, options: CallOptions) !list_timeline_events.ListTimelineEventsOutput {
        return list_timeline_events.execute(self, allocator, input, options);
    }

    /// Adds a resource policy to the specified response plan. The resource policy
    /// is used to
    /// share the response plan using Resource Access Manager (RAM). For more
    /// information about cross-account sharing, see [Cross-Region and cross-account
    /// incident
    /// management](https://docs.aws.amazon.com/incident-manager/latest/userguide/incident-manager-cross-account-cross-region.html).
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Used to start an incident from CloudWatch alarms, EventBridge events, or
    /// manually.
    pub fn startIncident(self: *Self, allocator: std.mem.Allocator, input: start_incident.StartIncidentInput, options: CallOptions) !start_incident.StartIncidentOutput {
        return start_incident.execute(self, allocator, input, options);
    }

    /// Adds a tag to a response plan.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update deletion protection to either allow or deny deletion of the final
    /// Region in a
    /// replication set.
    pub fn updateDeletionProtection(self: *Self, allocator: std.mem.Allocator, input: update_deletion_protection.UpdateDeletionProtectionInput, options: CallOptions) !update_deletion_protection.UpdateDeletionProtectionOutput {
        return update_deletion_protection.execute(self, allocator, input, options);
    }

    /// Update the details of an incident record. You can use this operation to
    /// update an incident
    /// record from the defined chat channel. For more information about using
    /// actions in chat
    /// channels, see [Interacting through
    /// chat](https://docs.aws.amazon.com/incident-manager/latest/userguide/chat.html#chat-interact).
    pub fn updateIncidentRecord(self: *Self, allocator: std.mem.Allocator, input: update_incident_record.UpdateIncidentRecordInput, options: CallOptions) !update_incident_record.UpdateIncidentRecordOutput {
        return update_incident_record.execute(self, allocator, input, options);
    }

    /// Add or remove related items from the related items tab of an incident
    /// record.
    pub fn updateRelatedItems(self: *Self, allocator: std.mem.Allocator, input: update_related_items.UpdateRelatedItemsInput, options: CallOptions) !update_related_items.UpdateRelatedItemsOutput {
        return update_related_items.execute(self, allocator, input, options);
    }

    /// Add or delete Regions from your replication set.
    pub fn updateReplicationSet(self: *Self, allocator: std.mem.Allocator, input: update_replication_set.UpdateReplicationSetInput, options: CallOptions) !update_replication_set.UpdateReplicationSetOutput {
        return update_replication_set.execute(self, allocator, input, options);
    }

    /// Updates the specified response plan.
    pub fn updateResponsePlan(self: *Self, allocator: std.mem.Allocator, input: update_response_plan.UpdateResponsePlanInput, options: CallOptions) !update_response_plan.UpdateResponsePlanOutput {
        return update_response_plan.execute(self, allocator, input, options);
    }

    /// Updates a timeline event. You can update events of type `Custom Event`.
    pub fn updateTimelineEvent(self: *Self, allocator: std.mem.Allocator, input: update_timeline_event.UpdateTimelineEventInput, options: CallOptions) !update_timeline_event.UpdateTimelineEventOutput {
        return update_timeline_event.execute(self, allocator, input, options);
    }

    pub fn getResourcePoliciesPaginator(self: *Self, params: get_resource_policies.GetResourcePoliciesInput) paginator.GetResourcePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIncidentFindingsPaginator(self: *Self, params: list_incident_findings.ListIncidentFindingsInput) paginator.ListIncidentFindingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIncidentRecordsPaginator(self: *Self, params: list_incident_records.ListIncidentRecordsInput) paginator.ListIncidentRecordsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRelatedItemsPaginator(self: *Self, params: list_related_items.ListRelatedItemsInput) paginator.ListRelatedItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReplicationSetsPaginator(self: *Self, params: list_replication_sets.ListReplicationSetsInput) paginator.ListReplicationSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResponsePlansPaginator(self: *Self, params: list_response_plans.ListResponsePlansInput) paginator.ListResponsePlansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTimelineEventsPaginator(self: *Self, params: list_timeline_events.ListTimelineEventsInput) paginator.ListTimelineEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilWaitForReplicationSetActive(self: *Self, params: get_replication_set.GetReplicationSetInput) aws.waiter.WaiterError!void {
        var w = waiters.WaitForReplicationSetActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilWaitForReplicationSetDeleted(self: *Self, params: get_replication_set.GetReplicationSetInput) aws.waiter.WaiterError!void {
        var w = waiters.WaitForReplicationSetDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
