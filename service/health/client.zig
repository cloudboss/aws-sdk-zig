const aws = @import("aws");
const std = @import("std");

const describe_affected_accounts_for_organization = @import("describe_affected_accounts_for_organization.zig");
const describe_affected_entities = @import("describe_affected_entities.zig");
const describe_affected_entities_for_organization = @import("describe_affected_entities_for_organization.zig");
const describe_entity_aggregates = @import("describe_entity_aggregates.zig");
const describe_entity_aggregates_for_organization = @import("describe_entity_aggregates_for_organization.zig");
const describe_event_aggregates = @import("describe_event_aggregates.zig");
const describe_event_details = @import("describe_event_details.zig");
const describe_event_details_for_organization = @import("describe_event_details_for_organization.zig");
const describe_event_types = @import("describe_event_types.zig");
const describe_events = @import("describe_events.zig");
const describe_events_for_organization = @import("describe_events_for_organization.zig");
const describe_health_service_status_for_organization = @import("describe_health_service_status_for_organization.zig");
const disable_health_service_access_for_organization = @import("disable_health_service_access_for_organization.zig");
const enable_health_service_access_for_organization = @import("enable_health_service_access_for_organization.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Health";

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

    /// Returns a list of accounts in the organization from Organizations that are
    /// affected by the
    /// provided event. For more information about the different types of Health
    /// events, see
    /// [Event](https://docs.aws.amazon.com/health/latest/APIReference/API_Event.html).
    ///
    /// Before you can call this operation, you must first enable Health to work
    /// with
    /// Organizations. To do this, call the
    /// [EnableHealthServiceAccessForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_EnableHealthServiceAccessForOrganization.html) operation from your organization's
    /// management account.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// next request to return more results.
    pub fn describeAffectedAccountsForOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_affected_accounts_for_organization.DescribeAffectedAccountsForOrganizationInput, options: CallOptions) !describe_affected_accounts_for_organization.DescribeAffectedAccountsForOrganizationOutput {
        return describe_affected_accounts_for_organization.execute(self, allocator, input, options);
    }

    /// Returns a list of entities that have been affected by the specified events,
    /// based on the
    /// specified filter criteria. Entities can refer to individual customer
    /// resources, groups of
    /// customer resources, or any other construct, depending on the Amazon Web
    /// Services service. Events that
    /// have impact beyond that of the affected entities, or where the extent of
    /// impact is unknown,
    /// include at least one entity indicating this.
    ///
    /// At least one event ARN is required.
    ///
    /// * This API operation uses pagination. Specify the `nextToken` parameter in
    ///   the next request to return more results.
    ///
    /// * This operation supports resource-level permissions. You can use this
    ///   operation to allow or deny access to specific Health events. For more
    /// information, see [Resource- and action-based
    /// conditions](https://docs.aws.amazon.com/health/latest/ug/security_iam_id-based-policy-examples.html#resource-action-based-conditions) in the *Health User Guide*.
    pub fn describeAffectedEntities(self: *Self, allocator: std.mem.Allocator, input: describe_affected_entities.DescribeAffectedEntitiesInput, options: CallOptions) !describe_affected_entities.DescribeAffectedEntitiesOutput {
        return describe_affected_entities.execute(self, allocator, input, options);
    }

    /// Returns a list of entities that have been affected by one or more events for
    /// one or more
    /// accounts in your organization in Organizations, based on the filter
    /// criteria. Entities can refer
    /// to individual customer resources, groups of customer resources, or any other
    /// construct,
    /// depending on the Amazon Web Services service.
    ///
    /// At least one event Amazon Resource Name (ARN) and account ID are required.
    ///
    /// Before you can call this operation, you must first enable Health to work
    /// with
    /// Organizations. To do this, call the
    /// [EnableHealthServiceAccessForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_EnableHealthServiceAccessForOrganization.html) operation from your organization's
    /// management account.
    ///
    /// * This API operation uses pagination. Specify the `nextToken` parameter in
    ///   the next request to return more results.
    ///
    /// * This operation doesn't support resource-level permissions. You can't use
    ///   this operation to allow or deny access to specific Health events. For more
    /// information, see [Resource- and action-based
    /// conditions](https://docs.aws.amazon.com/health/latest/ug/security_iam_id-based-policy-examples.html#resource-action-based-conditions) in the *Health User Guide*.
    pub fn describeAffectedEntitiesForOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_affected_entities_for_organization.DescribeAffectedEntitiesForOrganizationInput, options: CallOptions) !describe_affected_entities_for_organization.DescribeAffectedEntitiesForOrganizationOutput {
        return describe_affected_entities_for_organization.execute(self, allocator, input, options);
    }

    /// Returns the number of entities that are affected by each of the specified
    /// events.
    pub fn describeEntityAggregates(self: *Self, allocator: std.mem.Allocator, input: describe_entity_aggregates.DescribeEntityAggregatesInput, options: CallOptions) !describe_entity_aggregates.DescribeEntityAggregatesOutput {
        return describe_entity_aggregates.execute(self, allocator, input, options);
    }

    /// Returns a list of entity aggregates for your Organizations that are affected
    /// by each of the specified events.
    pub fn describeEntityAggregatesForOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_entity_aggregates_for_organization.DescribeEntityAggregatesForOrganizationInput, options: CallOptions) !describe_entity_aggregates_for_organization.DescribeEntityAggregatesForOrganizationOutput {
        return describe_entity_aggregates_for_organization.execute(self, allocator, input, options);
    }

    /// Returns the number of events of each event type (issue, scheduled change,
    /// and account
    /// notification). If no filter is specified, the counts of all events in each
    /// category are
    /// returned.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// next request to return more results.
    pub fn describeEventAggregates(self: *Self, allocator: std.mem.Allocator, input: describe_event_aggregates.DescribeEventAggregatesInput, options: CallOptions) !describe_event_aggregates.DescribeEventAggregatesOutput {
        return describe_event_aggregates.execute(self, allocator, input, options);
    }

    /// Returns detailed information about one or more specified events. Information
    /// includes
    /// standard event data (Amazon Web Services Region, service, and so on, as
    /// returned by
    /// [DescribeEvents](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEvents.html)), a detailed event description, and possible additional metadata
    /// that depends upon the nature of the event. Affected entities are not
    /// included. To retrieve
    /// the entities, use the
    /// [DescribeAffectedEntities](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedEntities.html) operation.
    ///
    /// If a specified event can't be retrieved, an error message is returned for
    /// that
    /// event.
    ///
    /// This operation supports resource-level permissions. You can use this
    /// operation to allow or deny access to specific Health events. For more
    /// information, see [Resource- and action-based
    /// conditions](https://docs.aws.amazon.com/health/latest/ug/security_iam_id-based-policy-examples.html#resource-action-based-conditions) in the *Health User Guide*.
    pub fn describeEventDetails(self: *Self, allocator: std.mem.Allocator, input: describe_event_details.DescribeEventDetailsInput, options: CallOptions) !describe_event_details.DescribeEventDetailsOutput {
        return describe_event_details.execute(self, allocator, input, options);
    }

    /// Returns detailed information about one or more specified events for one or
    /// more
    /// Amazon Web Services accounts in your organization. This information includes
    /// standard event data (such as
    /// the Amazon Web Services Region and service), an event description, and
    /// (depending on the event) possible
    /// metadata. This operation doesn't return affected entities, such as the
    /// resources related to
    /// the event. To return affected entities, use the
    /// [DescribeAffectedEntitiesForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedEntitiesForOrganization.html) operation.
    ///
    /// Before you can call this operation, you must first enable Health to work
    /// with
    /// Organizations. To do this, call the
    /// [EnableHealthServiceAccessForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_EnableHealthServiceAccessForOrganization.html) operation from your organization's
    /// management account.
    ///
    /// When you call the `DescribeEventDetailsForOrganization` operation, specify
    /// the `organizationEventDetailFilters` object in the request. Depending on the
    /// Health event type, note the following differences:
    ///
    /// * To return event details for a public event, you must specify a null value
    ///   for the
    /// `awsAccountId` parameter. If you specify an account ID for a public
    /// event, Health returns an error message because public events aren't specific
    /// to
    /// an account.
    ///
    /// * To return event details for an event that is specific to an account in
    ///   your
    /// organization, you must specify the `awsAccountId` parameter in the
    /// request. If you don't specify an account ID, Health returns an error message
    /// because the event is specific to an account in your organization.
    ///
    /// For more information, see
    /// [Event](https://docs.aws.amazon.com/health/latest/APIReference/API_Event.html).
    ///
    /// This operation doesn't support resource-level permissions. You can't use
    /// this operation to allow or deny access to specific Health events. For more
    /// information, see [Resource- and action-based
    /// conditions](https://docs.aws.amazon.com/health/latest/ug/security_iam_id-based-policy-examples.html#resource-action-based-conditions) in the *Health User Guide*.
    pub fn describeEventDetailsForOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_event_details_for_organization.DescribeEventDetailsForOrganizationInput, options: CallOptions) !describe_event_details_for_organization.DescribeEventDetailsForOrganizationOutput {
        return describe_event_details_for_organization.execute(self, allocator, input, options);
    }

    /// Returns the event types that meet the specified filter criteria. You can use
    /// this API
    /// operation to find information about the Health event, such as the category,
    /// Amazon Web Services service, and event code. The metadata for each event
    /// appears in the
    /// [EventType](https://docs.aws.amazon.com/health/latest/APIReference/API_EventType.html) object.
    ///
    /// If you don't specify a filter criteria, the API operation returns all event
    /// types, in no
    /// particular order.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// next request to return more results.
    pub fn describeEventTypes(self: *Self, allocator: std.mem.Allocator, input: describe_event_types.DescribeEventTypesInput, options: CallOptions) !describe_event_types.DescribeEventTypesOutput {
        return describe_event_types.execute(self, allocator, input, options);
    }

    /// Returns information about events that meet the specified filter criteria.
    /// Events are
    /// returned in a summary form and do not include the detailed description, any
    /// additional
    /// metadata that depends on the event type, or any affected resources. To
    /// retrieve that
    /// information, use the
    /// [DescribeEventDetails](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetails.html) and [DescribeAffectedEntities](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedEntities.html) operations.
    ///
    /// If no filter criteria are specified, all events are returned. Results are
    /// sorted by
    /// `lastModifiedTime`, starting with the most recent event.
    ///
    /// * When you call the `DescribeEvents` operation and specify an entity
    /// for the `entityValues` parameter, Health might return public
    /// events that aren't specific to that resource. For example, if you call
    /// `DescribeEvents` and specify an ID for an Amazon Elastic Compute Cloud
    /// (Amazon EC2)
    /// instance, Health might return events that aren't specific to that resource
    /// or
    /// service. To get events that are specific to a service, use the
    /// `services` parameter in the `filter` object. For more
    /// information, see
    /// [Event](https://docs.aws.amazon.com/health/latest/APIReference/API_Event.html).
    ///
    /// * This API operation uses pagination. Specify the `nextToken` parameter in
    ///   the next request to return more results.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: CallOptions) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Returns information about events across your organization in Organizations.
    /// You can use
    /// the`filters` parameter to specify the events that you want to return. Events
    /// are returned in a summary form and don't include the affected accounts,
    /// detailed
    /// description, any additional metadata that depends on the event type, or any
    /// affected
    /// resources. To retrieve that information, use the following operations:
    ///
    /// *
    ///   [DescribeAffectedAccountsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedAccountsForOrganization.html)
    ///
    /// *
    ///   [DescribeEventDetailsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetailsForOrganization.html)
    ///
    /// *
    ///   [DescribeAffectedEntitiesForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedEntitiesForOrganization.html)
    ///
    /// If you don't specify a `filter`, the
    /// `DescribeEventsForOrganizations` returns all events across your
    /// organization.
    /// Results are sorted by `lastModifiedTime`, starting with the most recent
    /// event.
    ///
    /// For more information about the different types of Health events, see
    /// [Event](https://docs.aws.amazon.com/health/latest/APIReference/API_Event.html).
    ///
    /// Before you can call this operation, you must first enable Health to work
    /// with
    /// Organizations. To do this, call the
    /// [EnableHealthServiceAccessForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_EnableHealthServiceAccessForOrganization.html) operation from your organization's
    /// management account.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// next request to return more results.
    pub fn describeEventsForOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_events_for_organization.DescribeEventsForOrganizationInput, options: CallOptions) !describe_events_for_organization.DescribeEventsForOrganizationOutput {
        return describe_events_for_organization.execute(self, allocator, input, options);
    }

    /// This operation provides status information on enabling or disabling Health
    /// to work
    /// with your organization. To call this operation, you must use the
    /// organization's
    /// management account.
    pub fn describeHealthServiceStatusForOrganization(self: *Self, allocator: std.mem.Allocator, input: describe_health_service_status_for_organization.DescribeHealthServiceStatusForOrganizationInput, options: CallOptions) !describe_health_service_status_for_organization.DescribeHealthServiceStatusForOrganizationOutput {
        return describe_health_service_status_for_organization.execute(self, allocator, input, options);
    }

    /// Disables Health from working with Organizations. To call this operation, you
    /// must sign
    /// in to the organization's management account. For more information, see
    /// [Aggregating
    /// Health
    /// events](https://docs.aws.amazon.com/health/latest/ug/aggregate-events.html)
    /// in the *Health User Guide*.
    ///
    /// This operation doesn't remove the service-linked role from the management
    /// account in your
    /// organization. You must use the IAM console, API, or Command Line Interface
    /// (CLI) to remove the
    /// service-linked role. For more information, see [Deleting a Service-Linked
    /// Role](https://docs.aws.amazon.com/IAM/latest/UserGuide/using-service-linked-roles.html#delete-service-linked-role) in the
    /// *IAM User Guide*.
    ///
    /// You can also disable the organizational feature by using the Organizations
    /// [DisableAWSServiceAccess](https://docs.aws.amazon.com/organizations/latest/APIReference/API_DisableAWSServiceAccess.html) API operation. After you call this operation,
    /// Health stops aggregating events for all other Amazon Web Services accounts
    /// in your organization.
    /// If you call the Health API operations for organizational view, Health
    /// returns
    /// an error. Health continues to aggregate health events for your
    /// Amazon Web Services account.
    pub fn disableHealthServiceAccessForOrganization(self: *Self, allocator: std.mem.Allocator, input: disable_health_service_access_for_organization.DisableHealthServiceAccessForOrganizationInput, options: CallOptions) !disable_health_service_access_for_organization.DisableHealthServiceAccessForOrganizationOutput {
        return disable_health_service_access_for_organization.execute(self, allocator, input, options);
    }

    /// Enables Health to work with Organizations. You can use the organizational
    /// view feature
    /// to aggregate events from all Amazon Web Services accounts in your
    /// organization in a centralized location.
    ///
    /// This operation also creates a service-linked role for the management account
    /// in the
    /// organization.
    ///
    /// To call this operation, you must meet the following requirements:
    ///
    /// * You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
    ///   from [Amazon Web Services Support](http://aws.amazon.com/premiumsupport/)
    ///   to use the Health API. If you call
    /// the Health API from an Amazon Web Services account that doesn't have a
    /// Business, Enterprise On-Ramp, or Enterprise Support plan, you receive a
    /// `SubscriptionRequiredException`
    /// error.
    ///
    /// * You must have permission to call this operation from the organization's
    /// management account. For example IAM policies, see [Health
    /// identity-based policy
    /// examples](https://docs.aws.amazon.com/health/latest/ug/security_iam_id-based-policy-examples.html).
    ///
    /// If you don't have the required support plan, you can instead use the Health
    /// console
    /// to enable the organizational view feature. For more information, see
    /// [Aggregating
    /// Health
    /// events](https://docs.aws.amazon.com/health/latest/ug/aggregate-events.html)
    /// in the *Health User Guide*.
    pub fn enableHealthServiceAccessForOrganization(self: *Self, allocator: std.mem.Allocator, input: enable_health_service_access_for_organization.EnableHealthServiceAccessForOrganizationInput, options: CallOptions) !enable_health_service_access_for_organization.EnableHealthServiceAccessForOrganizationOutput {
        return enable_health_service_access_for_organization.execute(self, allocator, input, options);
    }

    pub fn describeAffectedAccountsForOrganizationPaginator(self: *Self, params: describe_affected_accounts_for_organization.DescribeAffectedAccountsForOrganizationInput) paginator.DescribeAffectedAccountsForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeAffectedEntitiesPaginator(self: *Self, params: describe_affected_entities.DescribeAffectedEntitiesInput) paginator.DescribeAffectedEntitiesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeAffectedEntitiesForOrganizationPaginator(self: *Self, params: describe_affected_entities_for_organization.DescribeAffectedEntitiesForOrganizationInput) paginator.DescribeAffectedEntitiesForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeEventAggregatesPaginator(self: *Self, params: describe_event_aggregates.DescribeEventAggregatesInput) paginator.DescribeEventAggregatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeEventTypesPaginator(self: *Self, params: describe_event_types.DescribeEventTypesInput) paginator.DescribeEventTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeEventsPaginator(self: *Self, params: describe_events.DescribeEventsInput) paginator.DescribeEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeEventsForOrganizationPaginator(self: *Self, params: describe_events_for_organization.DescribeEventsForOrganizationInput) paginator.DescribeEventsForOrganizationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
