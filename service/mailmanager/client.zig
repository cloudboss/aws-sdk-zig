const aws = @import("aws");
const std = @import("std");

const create_addon_instance = @import("create_addon_instance.zig");
const create_addon_subscription = @import("create_addon_subscription.zig");
const create_address_list = @import("create_address_list.zig");
const create_address_list_import_job = @import("create_address_list_import_job.zig");
const create_archive = @import("create_archive.zig");
const create_ingress_point = @import("create_ingress_point.zig");
const create_relay = @import("create_relay.zig");
const create_rule_set = @import("create_rule_set.zig");
const create_traffic_policy = @import("create_traffic_policy.zig");
const delete_addon_instance = @import("delete_addon_instance.zig");
const delete_addon_subscription = @import("delete_addon_subscription.zig");
const delete_address_list = @import("delete_address_list.zig");
const delete_archive = @import("delete_archive.zig");
const delete_ingress_point = @import("delete_ingress_point.zig");
const delete_relay = @import("delete_relay.zig");
const delete_rule_set = @import("delete_rule_set.zig");
const delete_traffic_policy = @import("delete_traffic_policy.zig");
const deregister_member_from_address_list = @import("deregister_member_from_address_list.zig");
const get_addon_instance = @import("get_addon_instance.zig");
const get_addon_subscription = @import("get_addon_subscription.zig");
const get_address_list = @import("get_address_list.zig");
const get_address_list_import_job = @import("get_address_list_import_job.zig");
const get_archive = @import("get_archive.zig");
const get_archive_export = @import("get_archive_export.zig");
const get_archive_message = @import("get_archive_message.zig");
const get_archive_message_content = @import("get_archive_message_content.zig");
const get_archive_search = @import("get_archive_search.zig");
const get_archive_search_results = @import("get_archive_search_results.zig");
const get_ingress_point = @import("get_ingress_point.zig");
const get_member_of_address_list = @import("get_member_of_address_list.zig");
const get_relay = @import("get_relay.zig");
const get_rule_set = @import("get_rule_set.zig");
const get_traffic_policy = @import("get_traffic_policy.zig");
const list_addon_instances = @import("list_addon_instances.zig");
const list_addon_subscriptions = @import("list_addon_subscriptions.zig");
const list_address_list_import_jobs = @import("list_address_list_import_jobs.zig");
const list_address_lists = @import("list_address_lists.zig");
const list_archive_exports = @import("list_archive_exports.zig");
const list_archive_searches = @import("list_archive_searches.zig");
const list_archives = @import("list_archives.zig");
const list_ingress_points = @import("list_ingress_points.zig");
const list_members_of_address_list = @import("list_members_of_address_list.zig");
const list_relays = @import("list_relays.zig");
const list_rule_sets = @import("list_rule_sets.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_traffic_policies = @import("list_traffic_policies.zig");
const register_member_to_address_list = @import("register_member_to_address_list.zig");
const start_address_list_import_job = @import("start_address_list_import_job.zig");
const start_archive_export = @import("start_archive_export.zig");
const start_archive_search = @import("start_archive_search.zig");
const stop_address_list_import_job = @import("stop_address_list_import_job.zig");
const stop_archive_export = @import("stop_archive_export.zig");
const stop_archive_search = @import("stop_archive_search.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_archive = @import("update_archive.zig");
const update_ingress_point = @import("update_ingress_point.zig");
const update_relay = @import("update_relay.zig");
const update_rule_set = @import("update_rule_set.zig");
const update_traffic_policy = @import("update_traffic_policy.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MailManager";

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

    /// Creates an Add On instance for the subscription indicated in the request.
    /// The resulting Amazon Resource Name (ARN) can be used in a conditional
    /// statement for a rule set or traffic policy.
    pub fn createAddonInstance(self: *Self, allocator: std.mem.Allocator, input: create_addon_instance.CreateAddonInstanceInput, options: create_addon_instance.Options) !create_addon_instance.CreateAddonInstanceOutput {
        return create_addon_instance.execute(self, allocator, input, options);
    }

    /// Creates a subscription for an Add On representing the acceptance of its
    /// terms of use and additional pricing. The subscription can then be used to
    /// create an instance for use in rule sets or traffic policies.
    pub fn createAddonSubscription(self: *Self, allocator: std.mem.Allocator, input: create_addon_subscription.CreateAddonSubscriptionInput, options: create_addon_subscription.Options) !create_addon_subscription.CreateAddonSubscriptionOutput {
        return create_addon_subscription.execute(self, allocator, input, options);
    }

    /// Creates a new address list.
    pub fn createAddressList(self: *Self, allocator: std.mem.Allocator, input: create_address_list.CreateAddressListInput, options: create_address_list.Options) !create_address_list.CreateAddressListOutput {
        return create_address_list.execute(self, allocator, input, options);
    }

    /// Creates an import job for an address list.
    pub fn createAddressListImportJob(self: *Self, allocator: std.mem.Allocator, input: create_address_list_import_job.CreateAddressListImportJobInput, options: create_address_list_import_job.Options) !create_address_list_import_job.CreateAddressListImportJobOutput {
        return create_address_list_import_job.execute(self, allocator, input, options);
    }

    /// Creates a new email archive resource for storing and retaining emails.
    pub fn createArchive(self: *Self, allocator: std.mem.Allocator, input: create_archive.CreateArchiveInput, options: create_archive.Options) !create_archive.CreateArchiveOutput {
        return create_archive.execute(self, allocator, input, options);
    }

    /// Provision a new ingress endpoint resource.
    pub fn createIngressPoint(self: *Self, allocator: std.mem.Allocator, input: create_ingress_point.CreateIngressPointInput, options: create_ingress_point.Options) !create_ingress_point.CreateIngressPointOutput {
        return create_ingress_point.execute(self, allocator, input, options);
    }

    /// Creates a relay resource which can be used in rules to relay incoming emails
    /// to defined relay destinations.
    pub fn createRelay(self: *Self, allocator: std.mem.Allocator, input: create_relay.CreateRelayInput, options: create_relay.Options) !create_relay.CreateRelayOutput {
        return create_relay.execute(self, allocator, input, options);
    }

    /// Provision a new rule set.
    pub fn createRuleSet(self: *Self, allocator: std.mem.Allocator, input: create_rule_set.CreateRuleSetInput, options: create_rule_set.Options) !create_rule_set.CreateRuleSetOutput {
        return create_rule_set.execute(self, allocator, input, options);
    }

    /// Provision a new traffic policy resource.
    pub fn createTrafficPolicy(self: *Self, allocator: std.mem.Allocator, input: create_traffic_policy.CreateTrafficPolicyInput, options: create_traffic_policy.Options) !create_traffic_policy.CreateTrafficPolicyOutput {
        return create_traffic_policy.execute(self, allocator, input, options);
    }

    /// Deletes an Add On instance.
    pub fn deleteAddonInstance(self: *Self, allocator: std.mem.Allocator, input: delete_addon_instance.DeleteAddonInstanceInput, options: delete_addon_instance.Options) !delete_addon_instance.DeleteAddonInstanceOutput {
        return delete_addon_instance.execute(self, allocator, input, options);
    }

    /// Deletes an Add On subscription.
    pub fn deleteAddonSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_addon_subscription.DeleteAddonSubscriptionInput, options: delete_addon_subscription.Options) !delete_addon_subscription.DeleteAddonSubscriptionOutput {
        return delete_addon_subscription.execute(self, allocator, input, options);
    }

    /// Deletes an address list.
    pub fn deleteAddressList(self: *Self, allocator: std.mem.Allocator, input: delete_address_list.DeleteAddressListInput, options: delete_address_list.Options) !delete_address_list.DeleteAddressListOutput {
        return delete_address_list.execute(self, allocator, input, options);
    }

    /// Initiates deletion of an email archive. This changes the archive state to
    /// pending deletion. In this state, no new emails can be added, and existing
    /// archived emails become inaccessible (search, export, download). The archive
    /// and all of its contents will be permanently deleted 30 days after entering
    /// the pending deletion state, regardless of the configured retention period.
    pub fn deleteArchive(self: *Self, allocator: std.mem.Allocator, input: delete_archive.DeleteArchiveInput, options: delete_archive.Options) !delete_archive.DeleteArchiveOutput {
        return delete_archive.execute(self, allocator, input, options);
    }

    /// Delete an ingress endpoint resource.
    pub fn deleteIngressPoint(self: *Self, allocator: std.mem.Allocator, input: delete_ingress_point.DeleteIngressPointInput, options: delete_ingress_point.Options) !delete_ingress_point.DeleteIngressPointOutput {
        return delete_ingress_point.execute(self, allocator, input, options);
    }

    /// Deletes an existing relay resource.
    pub fn deleteRelay(self: *Self, allocator: std.mem.Allocator, input: delete_relay.DeleteRelayInput, options: delete_relay.Options) !delete_relay.DeleteRelayOutput {
        return delete_relay.execute(self, allocator, input, options);
    }

    /// Delete a rule set.
    pub fn deleteRuleSet(self: *Self, allocator: std.mem.Allocator, input: delete_rule_set.DeleteRuleSetInput, options: delete_rule_set.Options) !delete_rule_set.DeleteRuleSetOutput {
        return delete_rule_set.execute(self, allocator, input, options);
    }

    /// Delete a traffic policy resource.
    pub fn deleteTrafficPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_policy.DeleteTrafficPolicyInput, options: delete_traffic_policy.Options) !delete_traffic_policy.DeleteTrafficPolicyOutput {
        return delete_traffic_policy.execute(self, allocator, input, options);
    }

    /// Removes a member from an address list.
    pub fn deregisterMemberFromAddressList(self: *Self, allocator: std.mem.Allocator, input: deregister_member_from_address_list.DeregisterMemberFromAddressListInput, options: deregister_member_from_address_list.Options) !deregister_member_from_address_list.DeregisterMemberFromAddressListOutput {
        return deregister_member_from_address_list.execute(self, allocator, input, options);
    }

    /// Gets detailed information about an Add On instance.
    pub fn getAddonInstance(self: *Self, allocator: std.mem.Allocator, input: get_addon_instance.GetAddonInstanceInput, options: get_addon_instance.Options) !get_addon_instance.GetAddonInstanceOutput {
        return get_addon_instance.execute(self, allocator, input, options);
    }

    /// Gets detailed information about an Add On subscription.
    pub fn getAddonSubscription(self: *Self, allocator: std.mem.Allocator, input: get_addon_subscription.GetAddonSubscriptionInput, options: get_addon_subscription.Options) !get_addon_subscription.GetAddonSubscriptionOutput {
        return get_addon_subscription.execute(self, allocator, input, options);
    }

    /// Fetch attributes of an address list.
    pub fn getAddressList(self: *Self, allocator: std.mem.Allocator, input: get_address_list.GetAddressListInput, options: get_address_list.Options) !get_address_list.GetAddressListOutput {
        return get_address_list.execute(self, allocator, input, options);
    }

    /// Fetch attributes of an import job.
    pub fn getAddressListImportJob(self: *Self, allocator: std.mem.Allocator, input: get_address_list_import_job.GetAddressListImportJobInput, options: get_address_list_import_job.Options) !get_address_list_import_job.GetAddressListImportJobOutput {
        return get_address_list_import_job.execute(self, allocator, input, options);
    }

    /// Retrieves the full details and current state of a specified email archive.
    pub fn getArchive(self: *Self, allocator: std.mem.Allocator, input: get_archive.GetArchiveInput, options: get_archive.Options) !get_archive.GetArchiveOutput {
        return get_archive.execute(self, allocator, input, options);
    }

    /// Retrieves the details and current status of a specific email archive export
    /// job.
    pub fn getArchiveExport(self: *Self, allocator: std.mem.Allocator, input: get_archive_export.GetArchiveExportInput, options: get_archive_export.Options) !get_archive_export.GetArchiveExportOutput {
        return get_archive_export.execute(self, allocator, input, options);
    }

    /// Returns a pre-signed URL that provides temporary download access to the
    /// specific email message stored in the archive.
    pub fn getArchiveMessage(self: *Self, allocator: std.mem.Allocator, input: get_archive_message.GetArchiveMessageInput, options: get_archive_message.Options) !get_archive_message.GetArchiveMessageOutput {
        return get_archive_message.execute(self, allocator, input, options);
    }

    /// Returns the textual content of a specific email message stored in the
    /// archive. Attachments are not included.
    pub fn getArchiveMessageContent(self: *Self, allocator: std.mem.Allocator, input: get_archive_message_content.GetArchiveMessageContentInput, options: get_archive_message_content.Options) !get_archive_message_content.GetArchiveMessageContentOutput {
        return get_archive_message_content.execute(self, allocator, input, options);
    }

    /// Retrieves the details and current status of a specific email archive search
    /// job.
    pub fn getArchiveSearch(self: *Self, allocator: std.mem.Allocator, input: get_archive_search.GetArchiveSearchInput, options: get_archive_search.Options) !get_archive_search.GetArchiveSearchOutput {
        return get_archive_search.execute(self, allocator, input, options);
    }

    /// Returns the results of a completed email archive search job.
    pub fn getArchiveSearchResults(self: *Self, allocator: std.mem.Allocator, input: get_archive_search_results.GetArchiveSearchResultsInput, options: get_archive_search_results.Options) !get_archive_search_results.GetArchiveSearchResultsOutput {
        return get_archive_search_results.execute(self, allocator, input, options);
    }

    /// Fetch ingress endpoint resource attributes.
    pub fn getIngressPoint(self: *Self, allocator: std.mem.Allocator, input: get_ingress_point.GetIngressPointInput, options: get_ingress_point.Options) !get_ingress_point.GetIngressPointOutput {
        return get_ingress_point.execute(self, allocator, input, options);
    }

    /// Fetch attributes of a member in an address list.
    pub fn getMemberOfAddressList(self: *Self, allocator: std.mem.Allocator, input: get_member_of_address_list.GetMemberOfAddressListInput, options: get_member_of_address_list.Options) !get_member_of_address_list.GetMemberOfAddressListOutput {
        return get_member_of_address_list.execute(self, allocator, input, options);
    }

    /// Fetch the relay resource and it's attributes.
    pub fn getRelay(self: *Self, allocator: std.mem.Allocator, input: get_relay.GetRelayInput, options: get_relay.Options) !get_relay.GetRelayOutput {
        return get_relay.execute(self, allocator, input, options);
    }

    /// Fetch attributes of a rule set.
    pub fn getRuleSet(self: *Self, allocator: std.mem.Allocator, input: get_rule_set.GetRuleSetInput, options: get_rule_set.Options) !get_rule_set.GetRuleSetOutput {
        return get_rule_set.execute(self, allocator, input, options);
    }

    /// Fetch attributes of a traffic policy resource.
    pub fn getTrafficPolicy(self: *Self, allocator: std.mem.Allocator, input: get_traffic_policy.GetTrafficPolicyInput, options: get_traffic_policy.Options) !get_traffic_policy.GetTrafficPolicyOutput {
        return get_traffic_policy.execute(self, allocator, input, options);
    }

    /// Lists all Add On instances in your account.
    pub fn listAddonInstances(self: *Self, allocator: std.mem.Allocator, input: list_addon_instances.ListAddonInstancesInput, options: list_addon_instances.Options) !list_addon_instances.ListAddonInstancesOutput {
        return list_addon_instances.execute(self, allocator, input, options);
    }

    /// Lists all Add On subscriptions in your account.
    pub fn listAddonSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_addon_subscriptions.ListAddonSubscriptionsInput, options: list_addon_subscriptions.Options) !list_addon_subscriptions.ListAddonSubscriptionsOutput {
        return list_addon_subscriptions.execute(self, allocator, input, options);
    }

    /// Lists jobs for an address list.
    pub fn listAddressListImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_address_list_import_jobs.ListAddressListImportJobsInput, options: list_address_list_import_jobs.Options) !list_address_list_import_jobs.ListAddressListImportJobsOutput {
        return list_address_list_import_jobs.execute(self, allocator, input, options);
    }

    /// Lists address lists for this account.
    pub fn listAddressLists(self: *Self, allocator: std.mem.Allocator, input: list_address_lists.ListAddressListsInput, options: list_address_lists.Options) !list_address_lists.ListAddressListsOutput {
        return list_address_lists.execute(self, allocator, input, options);
    }

    /// Returns a list of email archive export jobs.
    pub fn listArchiveExports(self: *Self, allocator: std.mem.Allocator, input: list_archive_exports.ListArchiveExportsInput, options: list_archive_exports.Options) !list_archive_exports.ListArchiveExportsOutput {
        return list_archive_exports.execute(self, allocator, input, options);
    }

    /// Returns a list of email archive search jobs.
    pub fn listArchiveSearches(self: *Self, allocator: std.mem.Allocator, input: list_archive_searches.ListArchiveSearchesInput, options: list_archive_searches.Options) !list_archive_searches.ListArchiveSearchesOutput {
        return list_archive_searches.execute(self, allocator, input, options);
    }

    /// Returns a list of all email archives in your account.
    pub fn listArchives(self: *Self, allocator: std.mem.Allocator, input: list_archives.ListArchivesInput, options: list_archives.Options) !list_archives.ListArchivesOutput {
        return list_archives.execute(self, allocator, input, options);
    }

    /// List all ingress endpoint resources.
    pub fn listIngressPoints(self: *Self, allocator: std.mem.Allocator, input: list_ingress_points.ListIngressPointsInput, options: list_ingress_points.Options) !list_ingress_points.ListIngressPointsOutput {
        return list_ingress_points.execute(self, allocator, input, options);
    }

    /// Lists members of an address list.
    pub fn listMembersOfAddressList(self: *Self, allocator: std.mem.Allocator, input: list_members_of_address_list.ListMembersOfAddressListInput, options: list_members_of_address_list.Options) !list_members_of_address_list.ListMembersOfAddressListOutput {
        return list_members_of_address_list.execute(self, allocator, input, options);
    }

    /// Lists all the existing relay resources.
    pub fn listRelays(self: *Self, allocator: std.mem.Allocator, input: list_relays.ListRelaysInput, options: list_relays.Options) !list_relays.ListRelaysOutput {
        return list_relays.execute(self, allocator, input, options);
    }

    /// List rule sets for this account.
    pub fn listRuleSets(self: *Self, allocator: std.mem.Allocator, input: list_rule_sets.ListRuleSetsInput, options: list_rule_sets.Options) !list_rule_sets.ListRuleSetsOutput {
        return list_rule_sets.execute(self, allocator, input, options);
    }

    /// Retrieves the list of tags (keys and values) assigned to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List traffic policy resources.
    pub fn listTrafficPolicies(self: *Self, allocator: std.mem.Allocator, input: list_traffic_policies.ListTrafficPoliciesInput, options: list_traffic_policies.Options) !list_traffic_policies.ListTrafficPoliciesOutput {
        return list_traffic_policies.execute(self, allocator, input, options);
    }

    /// Adds a member to an address list.
    pub fn registerMemberToAddressList(self: *Self, allocator: std.mem.Allocator, input: register_member_to_address_list.RegisterMemberToAddressListInput, options: register_member_to_address_list.Options) !register_member_to_address_list.RegisterMemberToAddressListOutput {
        return register_member_to_address_list.execute(self, allocator, input, options);
    }

    /// Starts an import job for an address list.
    pub fn startAddressListImportJob(self: *Self, allocator: std.mem.Allocator, input: start_address_list_import_job.StartAddressListImportJobInput, options: start_address_list_import_job.Options) !start_address_list_import_job.StartAddressListImportJobOutput {
        return start_address_list_import_job.execute(self, allocator, input, options);
    }

    /// Initiates an export of emails from the specified archive.
    pub fn startArchiveExport(self: *Self, allocator: std.mem.Allocator, input: start_archive_export.StartArchiveExportInput, options: start_archive_export.Options) !start_archive_export.StartArchiveExportOutput {
        return start_archive_export.execute(self, allocator, input, options);
    }

    /// Initiates a search across emails in the specified archive.
    pub fn startArchiveSearch(self: *Self, allocator: std.mem.Allocator, input: start_archive_search.StartArchiveSearchInput, options: start_archive_search.Options) !start_archive_search.StartArchiveSearchOutput {
        return start_archive_search.execute(self, allocator, input, options);
    }

    /// Stops an ongoing import job for an address list.
    pub fn stopAddressListImportJob(self: *Self, allocator: std.mem.Allocator, input: stop_address_list_import_job.StopAddressListImportJobInput, options: stop_address_list_import_job.Options) !stop_address_list_import_job.StopAddressListImportJobOutput {
        return stop_address_list_import_job.execute(self, allocator, input, options);
    }

    /// Stops an in-progress export of emails from an archive.
    pub fn stopArchiveExport(self: *Self, allocator: std.mem.Allocator, input: stop_archive_export.StopArchiveExportInput, options: stop_archive_export.Options) !stop_archive_export.StopArchiveExportOutput {
        return stop_archive_export.execute(self, allocator, input, options);
    }

    /// Stops an in-progress archive search job.
    pub fn stopArchiveSearch(self: *Self, allocator: std.mem.Allocator, input: stop_archive_search.StopArchiveSearchInput, options: stop_archive_search.Options) !stop_archive_search.StopArchiveSearchOutput {
        return stop_archive_search.execute(self, allocator, input, options);
    }

    /// Adds one or more tags (keys and values) to a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove one or more tags (keys and values) from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the attributes of an existing email archive.
    pub fn updateArchive(self: *Self, allocator: std.mem.Allocator, input: update_archive.UpdateArchiveInput, options: update_archive.Options) !update_archive.UpdateArchiveOutput {
        return update_archive.execute(self, allocator, input, options);
    }

    /// Update attributes of a provisioned ingress endpoint resource.
    pub fn updateIngressPoint(self: *Self, allocator: std.mem.Allocator, input: update_ingress_point.UpdateIngressPointInput, options: update_ingress_point.Options) !update_ingress_point.UpdateIngressPointOutput {
        return update_ingress_point.execute(self, allocator, input, options);
    }

    /// Updates the attributes of an existing relay resource.
    pub fn updateRelay(self: *Self, allocator: std.mem.Allocator, input: update_relay.UpdateRelayInput, options: update_relay.Options) !update_relay.UpdateRelayOutput {
        return update_relay.execute(self, allocator, input, options);
    }

    /// Update attributes of an already provisioned rule set.
    pub fn updateRuleSet(self: *Self, allocator: std.mem.Allocator, input: update_rule_set.UpdateRuleSetInput, options: update_rule_set.Options) !update_rule_set.UpdateRuleSetOutput {
        return update_rule_set.execute(self, allocator, input, options);
    }

    /// Update attributes of an already provisioned traffic policy resource.
    pub fn updateTrafficPolicy(self: *Self, allocator: std.mem.Allocator, input: update_traffic_policy.UpdateTrafficPolicyInput, options: update_traffic_policy.Options) !update_traffic_policy.UpdateTrafficPolicyOutput {
        return update_traffic_policy.execute(self, allocator, input, options);
    }

    pub fn listAddonInstancesPaginator(self: *Self, params: list_addon_instances.ListAddonInstancesInput) paginator.ListAddonInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAddonSubscriptionsPaginator(self: *Self, params: list_addon_subscriptions.ListAddonSubscriptionsInput) paginator.ListAddonSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAddressListImportJobsPaginator(self: *Self, params: list_address_list_import_jobs.ListAddressListImportJobsInput) paginator.ListAddressListImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAddressListsPaginator(self: *Self, params: list_address_lists.ListAddressListsInput) paginator.ListAddressListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listArchiveExportsPaginator(self: *Self, params: list_archive_exports.ListArchiveExportsInput) paginator.ListArchiveExportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listArchiveSearchesPaginator(self: *Self, params: list_archive_searches.ListArchiveSearchesInput) paginator.ListArchiveSearchesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listArchivesPaginator(self: *Self, params: list_archives.ListArchivesInput) paginator.ListArchivesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIngressPointsPaginator(self: *Self, params: list_ingress_points.ListIngressPointsInput) paginator.ListIngressPointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMembersOfAddressListPaginator(self: *Self, params: list_members_of_address_list.ListMembersOfAddressListInput) paginator.ListMembersOfAddressListPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRelaysPaginator(self: *Self, params: list_relays.ListRelaysInput) paginator.ListRelaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRuleSetsPaginator(self: *Self, params: list_rule_sets.ListRuleSetsInput) paginator.ListRuleSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrafficPoliciesPaginator(self: *Self, params: list_traffic_policies.ListTrafficPoliciesInput) paginator.ListTrafficPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
