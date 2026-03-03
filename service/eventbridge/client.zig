const aws = @import("aws");
const std = @import("std");

const activate_event_source = @import("activate_event_source.zig");
const cancel_replay = @import("cancel_replay.zig");
const create_api_destination = @import("create_api_destination.zig");
const create_archive = @import("create_archive.zig");
const create_connection = @import("create_connection.zig");
const create_endpoint = @import("create_endpoint.zig");
const create_event_bus = @import("create_event_bus.zig");
const create_partner_event_source = @import("create_partner_event_source.zig");
const deactivate_event_source = @import("deactivate_event_source.zig");
const deauthorize_connection = @import("deauthorize_connection.zig");
const delete_api_destination = @import("delete_api_destination.zig");
const delete_archive = @import("delete_archive.zig");
const delete_connection = @import("delete_connection.zig");
const delete_endpoint = @import("delete_endpoint.zig");
const delete_event_bus = @import("delete_event_bus.zig");
const delete_partner_event_source = @import("delete_partner_event_source.zig");
const delete_rule = @import("delete_rule.zig");
const describe_api_destination = @import("describe_api_destination.zig");
const describe_archive = @import("describe_archive.zig");
const describe_connection = @import("describe_connection.zig");
const describe_endpoint = @import("describe_endpoint.zig");
const describe_event_bus = @import("describe_event_bus.zig");
const describe_event_source = @import("describe_event_source.zig");
const describe_partner_event_source = @import("describe_partner_event_source.zig");
const describe_replay = @import("describe_replay.zig");
const describe_rule = @import("describe_rule.zig");
const disable_rule = @import("disable_rule.zig");
const enable_rule = @import("enable_rule.zig");
const list_api_destinations = @import("list_api_destinations.zig");
const list_archives = @import("list_archives.zig");
const list_connections = @import("list_connections.zig");
const list_endpoints = @import("list_endpoints.zig");
const list_event_buses = @import("list_event_buses.zig");
const list_event_sources = @import("list_event_sources.zig");
const list_partner_event_source_accounts = @import("list_partner_event_source_accounts.zig");
const list_partner_event_sources = @import("list_partner_event_sources.zig");
const list_replays = @import("list_replays.zig");
const list_rule_names_by_target = @import("list_rule_names_by_target.zig");
const list_rules = @import("list_rules.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_targets_by_rule = @import("list_targets_by_rule.zig");
const put_events = @import("put_events.zig");
const put_partner_events = @import("put_partner_events.zig");
const put_permission = @import("put_permission.zig");
const put_rule = @import("put_rule.zig");
const put_targets = @import("put_targets.zig");
const remove_permission = @import("remove_permission.zig");
const remove_targets = @import("remove_targets.zig");
const start_replay = @import("start_replay.zig");
const tag_resource = @import("tag_resource.zig");
const test_event_pattern = @import("test_event_pattern.zig");
const untag_resource = @import("untag_resource.zig");
const update_api_destination = @import("update_api_destination.zig");
const update_archive = @import("update_archive.zig");
const update_connection = @import("update_connection.zig");
const update_endpoint = @import("update_endpoint.zig");
const update_event_bus = @import("update_event_bus.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EventBridge";

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

    /// Activates a partner event source that has been deactivated. Once activated,
    /// your matching
    /// event bus will start receiving events from the event source.
    pub fn activateEventSource(self: *Self, allocator: std.mem.Allocator, input: activate_event_source.ActivateEventSourceInput, options: CallOptions) !activate_event_source.ActivateEventSourceOutput {
        return activate_event_source.execute(self, allocator, input, options);
    }

    /// Cancels the specified replay.
    pub fn cancelReplay(self: *Self, allocator: std.mem.Allocator, input: cancel_replay.CancelReplayInput, options: CallOptions) !cancel_replay.CancelReplayOutput {
        return cancel_replay.execute(self, allocator, input, options);
    }

    /// Creates an API destination, which is an HTTP invocation endpoint configured
    /// as a target
    /// for events.
    ///
    /// API destinations do not support private destinations, such as interface VPC
    /// endpoints.
    ///
    /// For more information, see [API
    /// destinations](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-api-destinations.html) in the
    /// *EventBridge User Guide*.
    pub fn createApiDestination(self: *Self, allocator: std.mem.Allocator, input: create_api_destination.CreateApiDestinationInput, options: CallOptions) !create_api_destination.CreateApiDestinationOutput {
        return create_api_destination.execute(self, allocator, input, options);
    }

    /// Creates an archive of events with the specified settings. When you create an
    /// archive,
    /// incoming events might not immediately start being sent to the archive. Allow
    /// a short period of
    /// time for changes to take effect. If you do not specify a pattern to filter
    /// events sent to the
    /// archive, all events are sent to the archive except replayed events. Replayed
    /// events are not
    /// sent to an archive.
    ///
    /// If you have specified that EventBridge use a customer managed key for
    /// encrypting the source event bus, we strongly recommend you also specify a
    /// customer managed key for any archives for the event bus as well.
    ///
    /// For more information, see [Encrypting
    /// archives](https://docs.aws.amazon.com/eventbridge/latest/userguide/encryption-archives.html) in the *Amazon EventBridge User Guide*.
    pub fn createArchive(self: *Self, allocator: std.mem.Allocator, input: create_archive.CreateArchiveInput, options: CallOptions) !create_archive.CreateArchiveOutput {
        return create_archive.execute(self, allocator, input, options);
    }

    /// Creates a connection. A connection defines the authorization type and
    /// credentials to use
    /// for authorization with an API destination HTTP endpoint.
    ///
    /// For more information, see [Connections for endpoint
    /// targets](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-target-connection.html) in the *Amazon EventBridge User Guide*.
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: CallOptions) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Creates a global endpoint. Global endpoints improve your application's
    /// availability by
    /// making it regional-fault tolerant. To do this, you define a primary and
    /// secondary Region with
    /// event buses in each Region. You also create a Amazon Route 53 health check
    /// that will
    /// tell EventBridge to route events to the secondary Region when an "unhealthy"
    /// state is
    /// encountered and events will be routed back to the primary Region when the
    /// health check reports
    /// a "healthy" state.
    pub fn createEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_endpoint.CreateEndpointInput, options: CallOptions) !create_endpoint.CreateEndpointOutput {
        return create_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new event bus within your account. This can be a custom event bus
    /// which you can
    /// use to receive events from your custom applications and services, or it can
    /// be a partner event
    /// bus which can be matched to a partner event source.
    pub fn createEventBus(self: *Self, allocator: std.mem.Allocator, input: create_event_bus.CreateEventBusInput, options: CallOptions) !create_event_bus.CreateEventBusOutput {
        return create_event_bus.execute(self, allocator, input, options);
    }

    /// Called by an SaaS partner to create a partner event source. This operation
    /// is not used by
    /// Amazon Web Services customers.
    ///
    /// Each partner event source can be used by one Amazon Web Services account to
    /// create a
    /// matching partner event bus in that Amazon Web Services account. A SaaS
    /// partner must create one
    /// partner event source for each Amazon Web Services account that wants to
    /// receive those event
    /// types.
    ///
    /// A partner event source creates events based on resources within the SaaS
    /// partner's service
    /// or application.
    ///
    /// An Amazon Web Services account that creates a partner event bus that matches
    /// the partner
    /// event source can use that event bus to receive events from the partner, and
    /// then process them
    /// using Amazon Web Services Events rules and targets.
    ///
    /// Partner event source names follow this format:
    ///
    /// `
    /// *partner_name*/*event_namespace*/*event_name*
    /// `
    ///
    /// * *partner_name* is determined during partner registration, and
    /// identifies the partner to Amazon Web Services customers.
    ///
    /// * *event_namespace* is determined by the partner, and is a way for
    /// the partner to categorize their events.
    ///
    /// * *event_name* is determined by the partner, and should uniquely
    /// identify an event-generating resource within the partner system.
    ///
    /// The *event_name* must be unique across all Amazon Web Services
    /// customers. This is because the event source is a shared resource between the
    /// partner and
    /// customer accounts, and each partner event source unique in the partner
    /// account.
    ///
    /// The combination of *event_namespace* and
    /// *event_name* should help Amazon Web Services customers decide whether to
    /// create an event bus to receive these events.
    pub fn createPartnerEventSource(self: *Self, allocator: std.mem.Allocator, input: create_partner_event_source.CreatePartnerEventSourceInput, options: CallOptions) !create_partner_event_source.CreatePartnerEventSourceOutput {
        return create_partner_event_source.execute(self, allocator, input, options);
    }

    /// You can use this operation to temporarily stop receiving events from the
    /// specified partner
    /// event source. The matching event bus is not deleted.
    ///
    /// When you deactivate a partner event source, the source goes into PENDING
    /// state. If it
    /// remains in PENDING state for more than two weeks, it is deleted.
    ///
    /// To activate a deactivated partner event source, use
    /// [ActivateEventSource](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_ActivateEventSource.html).
    pub fn deactivateEventSource(self: *Self, allocator: std.mem.Allocator, input: deactivate_event_source.DeactivateEventSourceInput, options: CallOptions) !deactivate_event_source.DeactivateEventSourceOutput {
        return deactivate_event_source.execute(self, allocator, input, options);
    }

    /// Removes all authorization parameters from the connection. This lets you
    /// remove the secret
    /// from the connection so you can reuse it without having to create a new
    /// connection.
    pub fn deauthorizeConnection(self: *Self, allocator: std.mem.Allocator, input: deauthorize_connection.DeauthorizeConnectionInput, options: CallOptions) !deauthorize_connection.DeauthorizeConnectionOutput {
        return deauthorize_connection.execute(self, allocator, input, options);
    }

    /// Deletes the specified API destination.
    pub fn deleteApiDestination(self: *Self, allocator: std.mem.Allocator, input: delete_api_destination.DeleteApiDestinationInput, options: CallOptions) !delete_api_destination.DeleteApiDestinationOutput {
        return delete_api_destination.execute(self, allocator, input, options);
    }

    /// Deletes the specified archive.
    pub fn deleteArchive(self: *Self, allocator: std.mem.Allocator, input: delete_archive.DeleteArchiveInput, options: CallOptions) !delete_archive.DeleteArchiveOutput {
        return delete_archive.execute(self, allocator, input, options);
    }

    /// Deletes a connection.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: CallOptions) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Delete an existing global endpoint. For more information about global
    /// endpoints, see
    /// [Making applications Regional-fault tolerant with global endpoints and event
    /// replication](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-global-endpoints.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    pub fn deleteEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint.DeleteEndpointInput, options: CallOptions) !delete_endpoint.DeleteEndpointOutput {
        return delete_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes the specified custom event bus or partner event bus. All rules
    /// associated with
    /// this event bus need to be deleted. You can't delete your account's default
    /// event bus.
    pub fn deleteEventBus(self: *Self, allocator: std.mem.Allocator, input: delete_event_bus.DeleteEventBusInput, options: CallOptions) !delete_event_bus.DeleteEventBusOutput {
        return delete_event_bus.execute(self, allocator, input, options);
    }

    /// This operation is used by SaaS partners to delete a partner event source.
    /// This operation
    /// is not used by Amazon Web Services customers.
    ///
    /// When you delete an event source, the status of the corresponding partner
    /// event bus in the
    /// Amazon Web Services customer account becomes DELETED.
    pub fn deletePartnerEventSource(self: *Self, allocator: std.mem.Allocator, input: delete_partner_event_source.DeletePartnerEventSourceInput, options: CallOptions) !delete_partner_event_source.DeletePartnerEventSourceOutput {
        return delete_partner_event_source.execute(self, allocator, input, options);
    }

    /// Deletes the specified rule.
    ///
    /// Before you can delete the rule, you must remove all targets, using
    /// [RemoveTargets](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_RemoveTargets.html).
    ///
    /// When you delete a rule, incoming events might continue to match to the
    /// deleted rule. Allow
    /// a short period of time for changes to take effect.
    ///
    /// If you call delete rule multiple times for the same rule, all calls will
    /// succeed. When you
    /// call delete rule for a non-existent custom eventbus,
    /// `ResourceNotFoundException` is
    /// returned.
    ///
    /// Managed rules are rules created and managed by another Amazon Web Services
    /// service on your
    /// behalf. These rules are created by those other Amazon Web Services services
    /// to support
    /// functionality in those services. You can delete these rules using the
    /// `Force`
    /// option, but you should do so only if you are sure the other service is not
    /// still using that
    /// rule.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: CallOptions) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Retrieves details about an API destination.
    pub fn describeApiDestination(self: *Self, allocator: std.mem.Allocator, input: describe_api_destination.DescribeApiDestinationInput, options: CallOptions) !describe_api_destination.DescribeApiDestinationOutput {
        return describe_api_destination.execute(self, allocator, input, options);
    }

    /// Retrieves details about an archive.
    pub fn describeArchive(self: *Self, allocator: std.mem.Allocator, input: describe_archive.DescribeArchiveInput, options: CallOptions) !describe_archive.DescribeArchiveOutput {
        return describe_archive.execute(self, allocator, input, options);
    }

    /// Retrieves details about a connection.
    pub fn describeConnection(self: *Self, allocator: std.mem.Allocator, input: describe_connection.DescribeConnectionInput, options: CallOptions) !describe_connection.DescribeConnectionOutput {
        return describe_connection.execute(self, allocator, input, options);
    }

    /// Get the information about an existing global endpoint. For more information
    /// about global
    /// endpoints, see [Making applications
    /// Regional-fault tolerant with global endpoints and event
    /// replication](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-global-endpoints.html) in the
    /// *
    /// Amazon EventBridge User Guide*
    /// .
    pub fn describeEndpoint(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint.DescribeEndpointInput, options: CallOptions) !describe_endpoint.DescribeEndpointOutput {
        return describe_endpoint.execute(self, allocator, input, options);
    }

    /// Displays details about an event bus in your account. This can include the
    /// external Amazon Web Services accounts that are permitted to write events to
    /// your default event bus, and the
    /// associated policy. For custom event buses and partner event buses, it
    /// displays the name, ARN,
    /// policy, state, and creation time.
    ///
    /// To enable your account to receive events from other accounts on its default
    /// event bus,
    /// use
    /// [PutPermission](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutPermission.html).
    ///
    /// For more information about partner event buses, see
    /// [CreateEventBus](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_CreateEventBus.html).
    pub fn describeEventBus(self: *Self, allocator: std.mem.Allocator, input: describe_event_bus.DescribeEventBusInput, options: CallOptions) !describe_event_bus.DescribeEventBusOutput {
        return describe_event_bus.execute(self, allocator, input, options);
    }

    /// This operation lists details about a partner event source that is shared
    /// with your
    /// account.
    pub fn describeEventSource(self: *Self, allocator: std.mem.Allocator, input: describe_event_source.DescribeEventSourceInput, options: CallOptions) !describe_event_source.DescribeEventSourceOutput {
        return describe_event_source.execute(self, allocator, input, options);
    }

    /// An SaaS partner can use this operation to list details about a partner event
    /// source that
    /// they have created. Amazon Web Services customers do not use this operation.
    /// Instead, Amazon Web Services customers can use
    /// [DescribeEventSource](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_DescribeEventSource.html) to see details about a partner event source that is shared with
    /// them.
    pub fn describePartnerEventSource(self: *Self, allocator: std.mem.Allocator, input: describe_partner_event_source.DescribePartnerEventSourceInput, options: CallOptions) !describe_partner_event_source.DescribePartnerEventSourceOutput {
        return describe_partner_event_source.execute(self, allocator, input, options);
    }

    /// Retrieves details about a replay. Use `DescribeReplay` to determine the
    /// progress of a running replay. A replay processes events to replay based on
    /// the time in the
    /// event, and replays them using 1 minute intervals. If you use `StartReplay`
    /// and
    /// specify an `EventStartTime` and an `EventEndTime` that covers a 20
    /// minute time range, the events are replayed from the first minute of that 20
    /// minute range
    /// first. Then the events from the second minute are replayed. You can use
    /// `DescribeReplay` to determine the progress of a replay. The value returned
    /// for
    /// `EventLastReplayedTime` indicates the time within the specified time range
    /// associated with the last event replayed.
    pub fn describeReplay(self: *Self, allocator: std.mem.Allocator, input: describe_replay.DescribeReplayInput, options: CallOptions) !describe_replay.DescribeReplayOutput {
        return describe_replay.execute(self, allocator, input, options);
    }

    /// Describes the specified rule.
    ///
    /// DescribeRule does not list the targets of a rule. To see the targets
    /// associated with a
    /// rule, use
    /// [ListTargetsByRule](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_ListTargetsByRule.html).
    pub fn describeRule(self: *Self, allocator: std.mem.Allocator, input: describe_rule.DescribeRuleInput, options: CallOptions) !describe_rule.DescribeRuleOutput {
        return describe_rule.execute(self, allocator, input, options);
    }

    /// Disables the specified rule. A disabled rule won't match any events, and
    /// won't
    /// self-trigger if it has a schedule expression.
    ///
    /// When you disable a rule, incoming events might continue to match to the
    /// disabled rule.
    /// Allow a short period of time for changes to take effect.
    pub fn disableRule(self: *Self, allocator: std.mem.Allocator, input: disable_rule.DisableRuleInput, options: CallOptions) !disable_rule.DisableRuleOutput {
        return disable_rule.execute(self, allocator, input, options);
    }

    /// Enables the specified rule. If the rule does not exist, the operation fails.
    ///
    /// When you enable a rule, incoming events might not immediately start matching
    /// to a newly
    /// enabled rule. Allow a short period of time for changes to take effect.
    pub fn enableRule(self: *Self, allocator: std.mem.Allocator, input: enable_rule.EnableRuleInput, options: CallOptions) !enable_rule.EnableRuleOutput {
        return enable_rule.execute(self, allocator, input, options);
    }

    /// Retrieves a list of API destination in the account in the current Region.
    pub fn listApiDestinations(self: *Self, allocator: std.mem.Allocator, input: list_api_destinations.ListApiDestinationsInput, options: CallOptions) !list_api_destinations.ListApiDestinationsOutput {
        return list_api_destinations.execute(self, allocator, input, options);
    }

    /// Lists your archives. You can either list all the archives or you can provide
    /// a prefix to
    /// match to the archive names. Filter parameters are exclusive.
    pub fn listArchives(self: *Self, allocator: std.mem.Allocator, input: list_archives.ListArchivesInput, options: CallOptions) !list_archives.ListArchivesOutput {
        return list_archives.execute(self, allocator, input, options);
    }

    /// Retrieves a list of connections from the account.
    pub fn listConnections(self: *Self, allocator: std.mem.Allocator, input: list_connections.ListConnectionsInput, options: CallOptions) !list_connections.ListConnectionsOutput {
        return list_connections.execute(self, allocator, input, options);
    }

    /// List the global endpoints associated with this account. For more information
    /// about global
    /// endpoints, see [Making applications
    /// Regional-fault tolerant with global endpoints and event
    /// replication](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-global-endpoints.html) in the
    /// *
    /// Amazon EventBridge User Guide*
    /// .
    pub fn listEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_endpoints.ListEndpointsInput, options: CallOptions) !list_endpoints.ListEndpointsOutput {
        return list_endpoints.execute(self, allocator, input, options);
    }

    /// Lists all the event buses in your account, including the default event bus,
    /// custom event
    /// buses, and partner event buses.
    pub fn listEventBuses(self: *Self, allocator: std.mem.Allocator, input: list_event_buses.ListEventBusesInput, options: CallOptions) !list_event_buses.ListEventBusesOutput {
        return list_event_buses.execute(self, allocator, input, options);
    }

    /// You can use this to see all the partner event sources that have been shared
    /// with your
    /// Amazon Web Services account. For more information about partner event
    /// sources, see
    /// [CreateEventBus](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_CreateEventBus.html).
    pub fn listEventSources(self: *Self, allocator: std.mem.Allocator, input: list_event_sources.ListEventSourcesInput, options: CallOptions) !list_event_sources.ListEventSourcesOutput {
        return list_event_sources.execute(self, allocator, input, options);
    }

    /// An SaaS partner can use this operation to display the Amazon Web Services
    /// account ID that a
    /// particular partner event source name is associated with. This operation is
    /// not used by Amazon Web Services customers.
    pub fn listPartnerEventSourceAccounts(self: *Self, allocator: std.mem.Allocator, input: list_partner_event_source_accounts.ListPartnerEventSourceAccountsInput, options: CallOptions) !list_partner_event_source_accounts.ListPartnerEventSourceAccountsOutput {
        return list_partner_event_source_accounts.execute(self, allocator, input, options);
    }

    /// An SaaS partner can use this operation to list all the partner event source
    /// names that
    /// they have created. This operation is not used by Amazon Web Services
    /// customers.
    pub fn listPartnerEventSources(self: *Self, allocator: std.mem.Allocator, input: list_partner_event_sources.ListPartnerEventSourcesInput, options: CallOptions) !list_partner_event_sources.ListPartnerEventSourcesOutput {
        return list_partner_event_sources.execute(self, allocator, input, options);
    }

    /// Lists your replays. You can either list all the replays or you can provide a
    /// prefix to
    /// match to the replay names. Filter parameters are exclusive.
    pub fn listReplays(self: *Self, allocator: std.mem.Allocator, input: list_replays.ListReplaysInput, options: CallOptions) !list_replays.ListReplaysOutput {
        return list_replays.execute(self, allocator, input, options);
    }

    /// Lists the rules for the specified target. You can see which of the rules in
    /// Amazon
    /// EventBridge can invoke a specific target in your account.
    ///
    /// The maximum number of results per page for requests is 100.
    pub fn listRuleNamesByTarget(self: *Self, allocator: std.mem.Allocator, input: list_rule_names_by_target.ListRuleNamesByTargetInput, options: CallOptions) !list_rule_names_by_target.ListRuleNamesByTargetOutput {
        return list_rule_names_by_target.execute(self, allocator, input, options);
    }

    /// Lists your Amazon EventBridge rules. You can either list all the rules or
    /// you can
    /// provide a prefix to match to the rule names.
    ///
    /// The maximum number of results per page for requests is 100.
    ///
    /// ListRules does not list the targets of a rule. To see the targets associated
    /// with a rule,
    /// use
    /// [ListTargetsByRule](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_ListTargetsByRule.html).
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: CallOptions) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with an EventBridge resource. In EventBridge,
    /// rules and event
    /// buses can be tagged.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the targets assigned to the specified rule.
    ///
    /// The maximum number of results per page for requests is 100.
    pub fn listTargetsByRule(self: *Self, allocator: std.mem.Allocator, input: list_targets_by_rule.ListTargetsByRuleInput, options: CallOptions) !list_targets_by_rule.ListTargetsByRuleOutput {
        return list_targets_by_rule.execute(self, allocator, input, options);
    }

    /// Sends custom events to Amazon EventBridge so that they can be matched to
    /// rules.
    ///
    /// You can batch multiple event entries into one request for efficiency.
    /// However, the total entry size must be less than 256KB. You can calculate the
    /// entry size before you send the events.
    /// For more information, see [Calculating PutEvents event entry
    /// size](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-putevents.html#eb-putevent-size) in the *
    /// Amazon EventBridge User Guide*
    /// .
    ///
    /// PutEvents accepts the data in JSON format. For the JSON number (integer)
    /// data type, the
    /// constraints are: a minimum value of -9,223,372,036,854,775,808 and a maximum
    /// value of
    /// 9,223,372,036,854,775,807.
    ///
    /// PutEvents will only process nested JSON up to 1000 levels deep.
    pub fn putEvents(self: *Self, allocator: std.mem.Allocator, input: put_events.PutEventsInput, options: CallOptions) !put_events.PutEventsOutput {
        return put_events.execute(self, allocator, input, options);
    }

    /// This is used by SaaS partners to write events to a customer's partner event
    /// bus. Amazon Web Services customers do not use this operation.
    ///
    /// For information on calculating event batch size, see [Calculating
    /// EventBridge PutEvents event
    /// entry
    /// size](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-putevent-size.html) in the *EventBridge User Guide*.
    pub fn putPartnerEvents(self: *Self, allocator: std.mem.Allocator, input: put_partner_events.PutPartnerEventsInput, options: CallOptions) !put_partner_events.PutPartnerEventsOutput {
        return put_partner_events.execute(self, allocator, input, options);
    }

    /// Running `PutPermission` permits the specified Amazon Web Services account or
    /// Amazon Web Services organization
    /// to put events to the specified *event bus*. Amazon EventBridge rules in your
    /// account are triggered by these events arriving to an event bus in your
    /// account.
    ///
    /// For another account to send events to your account, that external account
    /// must have an
    /// EventBridge rule with your account's event bus as a target.
    ///
    /// To enable multiple Amazon Web Services accounts to put events to your event
    /// bus, run
    /// `PutPermission` once for each of these accounts. Or, if all the accounts are
    /// members of the same Amazon Web Services organization, you can run
    /// `PutPermission`
    /// once specifying `Principal` as "*" and specifying the Amazon Web Services
    /// organization ID in `Condition`, to grant permissions to all accounts in that
    /// organization.
    ///
    /// If you grant permissions using an organization, then accounts in that
    /// organization must
    /// specify a `RoleArn` with proper permissions when they use `PutTarget` to
    /// add your account's event bus as a target. For more information, see [Sending
    /// and
    /// Receiving Events Between Amazon Web Services
    /// Accounts](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-cross-account-event-delivery.html) in the *Amazon EventBridge User Guide*.
    ///
    /// The permission policy on the event bus cannot exceed 10 KB in size.
    pub fn putPermission(self: *Self, allocator: std.mem.Allocator, input: put_permission.PutPermissionInput, options: CallOptions) !put_permission.PutPermissionOutput {
        return put_permission.execute(self, allocator, input, options);
    }

    /// Creates or updates the specified rule. Rules are enabled by default, or
    /// based on value of
    /// the state. You can disable a rule using
    /// [DisableRule](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_DisableRule.html).
    ///
    /// A single rule watches for events from a single event bus. Events generated
    /// by Amazon Web Services services go to your account's default event bus.
    /// Events generated by SaaS partner
    /// services or applications go to the matching partner event bus. If you have
    /// custom applications
    /// or services, you can specify whether their events go to your default event
    /// bus or a custom
    /// event bus that you have created. For more information, see
    /// [CreateEventBus](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_CreateEventBus.html).
    ///
    /// If you are updating an existing rule, the rule is replaced with what you
    /// specify in this
    /// `PutRule` command. If you omit arguments in `PutRule`, the old values
    /// for those arguments are not kept. Instead, they are replaced with null
    /// values.
    ///
    /// When you create or update a rule, incoming events might not immediately
    /// start matching to
    /// new or updated rules. Allow a short period of time for changes to take
    /// effect.
    ///
    /// A rule must contain at least an EventPattern or ScheduleExpression. Rules
    /// with
    /// EventPatterns are triggered when a matching event is observed. Rules with
    /// ScheduleExpressions
    /// self-trigger based on the given schedule. A rule can have both an
    /// EventPattern and a
    /// ScheduleExpression, in which case the rule triggers on matching events as
    /// well as on a
    /// schedule.
    ///
    /// When you initially create a rule, you can optionally assign one or more tags
    /// to the rule.
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user
    /// permissions, by granting a user permission to access or change only rules
    /// with certain tag
    /// values. To use the `PutRule` operation and assign tags, you must have both
    /// the
    /// `events:PutRule` and `events:TagResource` permissions.
    ///
    /// If you are updating an existing rule, any tags you specify in the `PutRule`
    /// operation are ignored. To update the tags of an existing rule, use
    /// [TagResource](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_UntagResource.html).
    ///
    /// Most services in Amazon Web Services treat : or / as the same character in
    /// Amazon Resource
    /// Names (ARNs). However, EventBridge uses an exact match in event patterns and
    /// rules. Be sure to
    /// use the correct ARN characters when creating event patterns so that they
    /// match the ARN syntax
    /// in the event you want to match.
    ///
    /// In EventBridge, it is possible to create rules that lead to infinite loops,
    /// where a rule
    /// is fired repeatedly. For example, a rule might detect that ACLs have changed
    /// on an S3 bucket,
    /// and trigger software to change them to the desired state. If the rule is not
    /// written
    /// carefully, the subsequent change to the ACLs fires the rule again, creating
    /// an infinite
    /// loop.
    ///
    /// To prevent this, write the rules so that the triggered actions do not
    /// re-fire the same
    /// rule. For example, your rule could fire only if ACLs are found to be in a
    /// bad state, instead
    /// of after any change.
    ///
    /// An infinite loop can quickly cause higher than expected charges. We
    /// recommend that you use
    /// budgeting, which alerts you when charges exceed your specified limit. For
    /// more information,
    /// see [Managing Your Costs with
    /// Budgets](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/budgets-managing-costs.html).
    ///
    /// To create a rule that filters for management events from Amazon Web Services
    /// services, see
    /// [Receiving read-only management events from Amazon Web Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event-cloudtrail.html#eb-service-event-cloudtrail-management) in the
    /// *EventBridge User Guide*.
    pub fn putRule(self: *Self, allocator: std.mem.Allocator, input: put_rule.PutRuleInput, options: CallOptions) !put_rule.PutRuleOutput {
        return put_rule.execute(self, allocator, input, options);
    }

    /// Adds the specified targets to the specified rule, or updates the targets if
    /// they are
    /// already associated with the rule.
    ///
    /// Targets are the resources that are invoked when a rule is triggered.
    ///
    /// The maximum number of entries per request is 10.
    ///
    /// Each rule can have up to five (5) targets associated with it at one time.
    ///
    /// For a list of services you can configure as targets for events, see
    /// [EventBridge
    /// targets](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-targets.html)
    /// in the *
    /// Amazon EventBridge User Guide*
    /// .
    ///
    /// Creating rules with built-in targets is supported only in the Amazon Web
    /// Services Management Console. The
    /// built-in targets are:
    ///
    /// * `Amazon EBS CreateSnapshot API call`
    ///
    /// * `Amazon EC2 RebootInstances API call`
    ///
    /// * `Amazon EC2 StopInstances API call`
    ///
    /// * `Amazon EC2 TerminateInstances API call`
    ///
    /// For some target types, `PutTargets` provides target-specific parameters. If
    /// the
    /// target is a Kinesis data stream, you can optionally specify which shard the
    /// event
    /// goes to by using the `KinesisParameters` argument. To invoke a command on
    /// multiple
    /// EC2 instances with one rule, you can use the `RunCommandParameters` field.
    ///
    /// To be able to make API calls against the resources that you own, Amazon
    /// EventBridge
    /// needs the appropriate permissions:
    ///
    /// * For Lambda and Amazon SNS resources, EventBridge relies
    /// on resource-based policies.
    ///
    /// * For EC2 instances, Kinesis Data Streams, Step Functions state machines and
    /// API Gateway APIs, EventBridge relies on IAM roles that you specify in the
    /// `RoleARN` argument in `PutTargets`.
    ///
    /// For more information, see [Authentication
    /// and Access
    /// Control](https://docs.aws.amazon.com/eventbridge/latest/userguide/auth-and-access-control-eventbridge.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    ///
    /// If another Amazon Web Services account is in the same region and has granted
    /// you permission
    /// (using `PutPermission`), you can send events to that account. Set that
    /// account's
    /// event bus as a target of the rules in your account. To send the matched
    /// events to the other
    /// account, specify that account's event bus as the `Arn` value when you run
    /// `PutTargets`. If your account sends events to another account, your account
    /// is
    /// charged for each sent event. Each event sent to another account is charged
    /// as a custom event.
    /// The account receiving the event is not charged. For more information, see
    /// [Amazon EventBridge Pricing](http://aws.amazon.com/eventbridge/pricing/).
    ///
    /// `Input`, `InputPath`, and `InputTransformer` are not
    /// available with `PutTarget` if the target is an event bus of a different
    /// Amazon Web Services account.
    ///
    /// If you are setting the event bus of another account as the target, and that
    /// account
    /// granted permission to your account through an organization instead of
    /// directly by the account
    /// ID, then you must specify a `RoleArn` with proper permissions in the
    /// `Target` structure. For more information, see [Sending and
    /// Receiving Events Between Amazon Web Services
    /// Accounts](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-cross-account-event-delivery.html) in the *Amazon EventBridge User Guide*.
    ///
    /// If you have an IAM role on a cross-account event bus target, a `PutTargets`
    /// call without a role on the same target (same `Id` and `Arn`) will not
    /// remove the role.
    ///
    /// For more information about enabling cross-account events, see
    /// [PutPermission](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutPermission.html).
    ///
    /// **Input**, **InputPath**, and
    /// **InputTransformer** are mutually exclusive and optional
    /// parameters of a target. When a rule is triggered due to a matched event:
    ///
    /// * If none of the following arguments are specified for a target, then the
    ///   entire event
    /// is passed to the target in JSON format (unless the target is Amazon EC2 Run
    /// Command or
    /// Amazon ECS task, in which case nothing from the event is passed to the
    /// target).
    ///
    /// * If **Input** is specified in the form of valid JSON, then
    /// the matched event is overridden with this constant.
    ///
    /// * If **InputPath** is specified in the form of JSONPath
    /// (for example, `$.detail`), then only the part of the event specified in the
    /// path is passed to the target (for example, only the detail part of the event
    /// is
    /// passed).
    ///
    /// * If **InputTransformer** is specified, then one or more
    /// specified JSONPaths are extracted from the event and used as values in a
    /// template that you
    /// specify as the input to the target.
    ///
    /// When you specify `InputPath` or `InputTransformer`, you must use
    /// JSON dot notation, not bracket notation.
    ///
    /// When you add targets to a rule and the associated rule triggers soon after,
    /// new or updated
    /// targets might not be immediately invoked. Allow a short period of time for
    /// changes to take
    /// effect.
    ///
    /// This action can partially fail if too many requests are made at the same
    /// time. If that
    /// happens, `FailedEntryCount` is non-zero in the response and each entry in
    /// `FailedEntries` provides the ID of the failed target and the error code.
    pub fn putTargets(self: *Self, allocator: std.mem.Allocator, input: put_targets.PutTargetsInput, options: CallOptions) !put_targets.PutTargetsOutput {
        return put_targets.execute(self, allocator, input, options);
    }

    /// Revokes the permission of another Amazon Web Services account to be able to
    /// put events to
    /// the specified event bus. Specify the account to revoke by the `StatementId`
    /// value
    /// that you associated with the account when you granted it permission with
    /// `PutPermission`. You can find the `StatementId` by using
    /// [DescribeEventBus](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_DescribeEventBus.html).
    pub fn removePermission(self: *Self, allocator: std.mem.Allocator, input: remove_permission.RemovePermissionInput, options: CallOptions) !remove_permission.RemovePermissionOutput {
        return remove_permission.execute(self, allocator, input, options);
    }

    /// Removes the specified targets from the specified rule. When the rule is
    /// triggered, those
    /// targets are no longer be invoked.
    ///
    /// A successful execution of `RemoveTargets` doesn't guarantee all targets are
    /// removed from the rule, it means that the target(s) listed in the request are
    /// removed.
    ///
    /// When you remove a target, when the associated rule triggers, removed targets
    /// might
    /// continue to be invoked. Allow a short period of time for changes to take
    /// effect.
    ///
    /// This action can partially fail if too many requests are made at the same
    /// time. If that
    /// happens, `FailedEntryCount` is non-zero in the response and each entry in
    /// `FailedEntries` provides the ID of the failed target and the error code.
    ///
    /// The maximum number of entries per request is 10.
    pub fn removeTargets(self: *Self, allocator: std.mem.Allocator, input: remove_targets.RemoveTargetsInput, options: CallOptions) !remove_targets.RemoveTargetsOutput {
        return remove_targets.execute(self, allocator, input, options);
    }

    /// Starts the specified replay. Events are not necessarily replayed in the
    /// exact same order
    /// that they were added to the archive. A replay processes events to replay
    /// based on the time in
    /// the event, and replays them using 1 minute intervals. If you specify an
    /// `EventStartTime` and an `EventEndTime` that covers a 20 minute time
    /// range, the events are replayed from the first minute of that 20 minute range
    /// first. Then the
    /// events from the second minute are replayed. You can use `DescribeReplay` to
    /// determine the progress of a replay. The value returned for
    /// `EventLastReplayedTime`
    /// indicates the time within the specified time range associated with the last
    /// event
    /// replayed.
    pub fn startReplay(self: *Self, allocator: std.mem.Allocator, input: start_replay.StartReplayInput, options: CallOptions) !start_replay.StartReplayOutput {
        return start_replay.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified EventBridge
    /// resource. Tags can
    /// help you organize and categorize your resources. You can also use them to
    /// scope user
    /// permissions by granting a user permission to access or change only resources
    /// with certain tag
    /// values. In EventBridge, rules and event buses can be tagged.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as
    /// strings of characters.
    ///
    /// You can use the `TagResource` action with a resource that already has tags.
    /// If
    /// you specify a new tag key, this tag is appended to the list of tags
    /// associated with the
    /// resource. If you specify a tag key that is already associated with the
    /// resource, the new tag
    /// value that you specify replaces the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests whether the specified event pattern matches the provided event.
    ///
    /// Most services in Amazon Web Services treat : or / as the same character in
    /// Amazon Resource
    /// Names (ARNs). However, EventBridge uses an exact match in event patterns and
    /// rules. Be
    /// sure to use the correct ARN characters when creating event patterns so that
    /// they match the ARN
    /// syntax in the event you want to match.
    pub fn testEventPattern(self: *Self, allocator: std.mem.Allocator, input: test_event_pattern.TestEventPatternInput, options: CallOptions) !test_event_pattern.TestEventPatternOutput {
        return test_event_pattern.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified EventBridge resource. In Amazon
    /// EventBridge, rules and event buses can be tagged.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an API destination.
    pub fn updateApiDestination(self: *Self, allocator: std.mem.Allocator, input: update_api_destination.UpdateApiDestinationInput, options: CallOptions) !update_api_destination.UpdateApiDestinationOutput {
        return update_api_destination.execute(self, allocator, input, options);
    }

    /// Updates the specified archive.
    pub fn updateArchive(self: *Self, allocator: std.mem.Allocator, input: update_archive.UpdateArchiveInput, options: CallOptions) !update_archive.UpdateArchiveOutput {
        return update_archive.execute(self, allocator, input, options);
    }

    /// Updates settings for a connection.
    pub fn updateConnection(self: *Self, allocator: std.mem.Allocator, input: update_connection.UpdateConnectionInput, options: CallOptions) !update_connection.UpdateConnectionOutput {
        return update_connection.execute(self, allocator, input, options);
    }

    /// Update an existing endpoint. For more information about global endpoints,
    /// see [Making
    /// applications Regional-fault tolerant with global endpoints and event
    /// replication](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-global-endpoints.html) in
    /// the *
    /// Amazon EventBridge User Guide*
    /// .
    pub fn updateEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_endpoint.UpdateEndpointInput, options: CallOptions) !update_endpoint.UpdateEndpointOutput {
        return update_endpoint.execute(self, allocator, input, options);
    }

    /// Updates the specified event bus.
    pub fn updateEventBus(self: *Self, allocator: std.mem.Allocator, input: update_event_bus.UpdateEventBusInput, options: CallOptions) !update_event_bus.UpdateEventBusOutput {
        return update_event_bus.execute(self, allocator, input, options);
    }
};
