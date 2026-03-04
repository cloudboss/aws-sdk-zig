const aws = @import("aws");
const std = @import("std");

const cancel_flow_executions = @import("cancel_flow_executions.zig");
const create_connector_profile = @import("create_connector_profile.zig");
const create_flow = @import("create_flow.zig");
const delete_connector_profile = @import("delete_connector_profile.zig");
const delete_flow = @import("delete_flow.zig");
const describe_connector = @import("describe_connector.zig");
const describe_connector_entity = @import("describe_connector_entity.zig");
const describe_connector_profiles = @import("describe_connector_profiles.zig");
const describe_connectors = @import("describe_connectors.zig");
const describe_flow = @import("describe_flow.zig");
const describe_flow_execution_records = @import("describe_flow_execution_records.zig");
const list_connector_entities = @import("list_connector_entities.zig");
const list_connectors = @import("list_connectors.zig");
const list_flows = @import("list_flows.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_connector = @import("register_connector.zig");
const reset_connector_metadata_cache = @import("reset_connector_metadata_cache.zig");
const start_flow = @import("start_flow.zig");
const stop_flow = @import("stop_flow.zig");
const tag_resource = @import("tag_resource.zig");
const unregister_connector = @import("unregister_connector.zig");
const untag_resource = @import("untag_resource.zig");
const update_connector_profile = @import("update_connector_profile.zig");
const update_connector_registration = @import("update_connector_registration.zig");
const update_flow = @import("update_flow.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Appflow";

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

    /// Cancels active runs for a flow.
    ///
    /// You can cancel all of the active runs for a flow, or you can cancel specific
    /// runs by
    /// providing their IDs.
    ///
    /// You can cancel a flow run only when the run is in progress. You can't cancel
    /// a run that
    /// has already completed or failed. You also can't cancel a run that's
    /// scheduled to occur but
    /// hasn't started yet. To prevent a scheduled run, you can deactivate the flow
    /// with the
    /// `StopFlow` action.
    ///
    /// You cannot resume a run after you cancel it.
    ///
    /// When you send your request, the status for each run becomes `CancelStarted`.
    /// When the cancellation completes, the status becomes `Canceled`.
    ///
    /// When you cancel a run, you still incur charges for any data that the run
    /// already
    /// processed before the cancellation. If the run had already written some data
    /// to the flow
    /// destination, then that data remains in the destination. If you configured
    /// the flow to use a
    /// batch API (such as the Salesforce Bulk API 2.0), then the run will finish
    /// reading or writing
    /// its entire batch of data after the cancellation. For these operations, the
    /// data processing
    /// charges for Amazon AppFlow apply. For the pricing information, see [Amazon
    /// AppFlow pricing](http://aws.amazon.com/appflow/pricing/).
    pub fn cancelFlowExecutions(self: *Self, allocator: std.mem.Allocator, input: cancel_flow_executions.CancelFlowExecutionsInput, options: CallOptions) !cancel_flow_executions.CancelFlowExecutionsOutput {
        return cancel_flow_executions.execute(self, allocator, input, options);
    }

    /// Creates a new connector profile associated with your Amazon Web Services
    /// account. There is
    /// a soft quota of 100 connector profiles per Amazon Web Services account. If
    /// you need more
    /// connector profiles than this quota allows, you can submit a request to the
    /// Amazon AppFlow
    /// team through the Amazon AppFlow support channel. In each connector profile
    /// that you
    /// create, you can provide the credentials and properties for only one
    /// connector.
    pub fn createConnectorProfile(self: *Self, allocator: std.mem.Allocator, input: create_connector_profile.CreateConnectorProfileInput, options: CallOptions) !create_connector_profile.CreateConnectorProfileOutput {
        return create_connector_profile.execute(self, allocator, input, options);
    }

    /// Enables your application to create a new flow using Amazon AppFlow. You must
    /// create
    /// a connector profile before calling this API. Please note that the Request
    /// Syntax below shows
    /// syntax for multiple destinations, however, you can only transfer data to one
    /// item in this list
    /// at a time. Amazon AppFlow does not currently support flows to multiple
    /// destinations at
    /// once.
    pub fn createFlow(self: *Self, allocator: std.mem.Allocator, input: create_flow.CreateFlowInput, options: CallOptions) !create_flow.CreateFlowOutput {
        return create_flow.execute(self, allocator, input, options);
    }

    /// Enables you to delete an existing connector profile.
    pub fn deleteConnectorProfile(self: *Self, allocator: std.mem.Allocator, input: delete_connector_profile.DeleteConnectorProfileInput, options: CallOptions) !delete_connector_profile.DeleteConnectorProfileOutput {
        return delete_connector_profile.execute(self, allocator, input, options);
    }

    /// Enables your application to delete an existing flow. Before deleting the
    /// flow, Amazon AppFlow validates the request by checking the flow
    /// configuration and status. You can
    /// delete flows one at a time.
    pub fn deleteFlow(self: *Self, allocator: std.mem.Allocator, input: delete_flow.DeleteFlowInput, options: CallOptions) !delete_flow.DeleteFlowOutput {
        return delete_flow.execute(self, allocator, input, options);
    }

    /// Describes the given custom connector registered in your Amazon Web Services
    /// account. This
    /// API can be used for custom connectors that are registered in your account
    /// and also for Amazon
    /// authored connectors.
    pub fn describeConnector(self: *Self, allocator: std.mem.Allocator, input: describe_connector.DescribeConnectorInput, options: CallOptions) !describe_connector.DescribeConnectorOutput {
        return describe_connector.execute(self, allocator, input, options);
    }

    /// Provides details regarding the entity used with the connector, with a
    /// description of the
    /// data model for each field in that entity.
    pub fn describeConnectorEntity(self: *Self, allocator: std.mem.Allocator, input: describe_connector_entity.DescribeConnectorEntityInput, options: CallOptions) !describe_connector_entity.DescribeConnectorEntityOutput {
        return describe_connector_entity.execute(self, allocator, input, options);
    }

    /// Returns a list of `connector-profile` details matching the provided
    /// `connector-profile` names and `connector-types`. Both input lists are
    /// optional, and you can use them to filter the result.
    ///
    /// If no names or `connector-types` are provided, returns all connector
    /// profiles
    /// in a paginated form. If there is no match, this operation returns an empty
    /// list.
    pub fn describeConnectorProfiles(self: *Self, allocator: std.mem.Allocator, input: describe_connector_profiles.DescribeConnectorProfilesInput, options: CallOptions) !describe_connector_profiles.DescribeConnectorProfilesOutput {
        return describe_connector_profiles.execute(self, allocator, input, options);
    }

    /// Describes the connectors vended by Amazon AppFlow for specified connector
    /// types. If
    /// you don't specify a connector type, this operation describes all connectors
    /// vended by Amazon AppFlow. If there are more connectors than can be returned
    /// in one page, the response
    /// contains a `nextToken` object, which can be be passed in to the next call to
    /// the
    /// `DescribeConnectors` API operation to retrieve the next page.
    pub fn describeConnectors(self: *Self, allocator: std.mem.Allocator, input: describe_connectors.DescribeConnectorsInput, options: CallOptions) !describe_connectors.DescribeConnectorsOutput {
        return describe_connectors.execute(self, allocator, input, options);
    }

    /// Provides a description of the specified flow.
    pub fn describeFlow(self: *Self, allocator: std.mem.Allocator, input: describe_flow.DescribeFlowInput, options: CallOptions) !describe_flow.DescribeFlowOutput {
        return describe_flow.execute(self, allocator, input, options);
    }

    /// Fetches the execution history of the flow.
    pub fn describeFlowExecutionRecords(self: *Self, allocator: std.mem.Allocator, input: describe_flow_execution_records.DescribeFlowExecutionRecordsInput, options: CallOptions) !describe_flow_execution_records.DescribeFlowExecutionRecordsOutput {
        return describe_flow_execution_records.execute(self, allocator, input, options);
    }

    /// Returns the list of available connector entities supported by Amazon
    /// AppFlow. For
    /// example, you can query Salesforce for *Account* and
    /// *Opportunity* entities, or query ServiceNow for the
    /// *Incident* entity.
    pub fn listConnectorEntities(self: *Self, allocator: std.mem.Allocator, input: list_connector_entities.ListConnectorEntitiesInput, options: CallOptions) !list_connector_entities.ListConnectorEntitiesOutput {
        return list_connector_entities.execute(self, allocator, input, options);
    }

    /// Returns the list of all registered custom connectors in your Amazon Web
    /// Services account.
    /// This API lists only custom connectors registered in this account, not the
    /// Amazon Web Services
    /// authored connectors.
    pub fn listConnectors(self: *Self, allocator: std.mem.Allocator, input: list_connectors.ListConnectorsInput, options: CallOptions) !list_connectors.ListConnectorsOutput {
        return list_connectors.execute(self, allocator, input, options);
    }

    /// Lists all of the flows associated with your account.
    pub fn listFlows(self: *Self, allocator: std.mem.Allocator, input: list_flows.ListFlowsInput, options: CallOptions) !list_flows.ListFlowsOutput {
        return list_flows.execute(self, allocator, input, options);
    }

    /// Retrieves the tags that are associated with a specified flow.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Registers a new custom connector with your Amazon Web Services account.
    /// Before you can
    /// register the connector, you must deploy the associated AWS lambda function
    /// in your
    /// account.
    pub fn registerConnector(self: *Self, allocator: std.mem.Allocator, input: register_connector.RegisterConnectorInput, options: CallOptions) !register_connector.RegisterConnectorOutput {
        return register_connector.execute(self, allocator, input, options);
    }

    /// Resets metadata about your connector entities that Amazon AppFlow stored in
    /// its
    /// cache. Use this action when you want Amazon AppFlow to return the latest
    /// information
    /// about the data that you have in a source application.
    ///
    /// Amazon AppFlow returns metadata about your entities when you use the
    /// ListConnectorEntities or DescribeConnectorEntities actions. Following these
    /// actions, Amazon AppFlow caches the metadata to reduce the number of API
    /// requests that it must send to
    /// the source application. Amazon AppFlow automatically resets the cache once
    /// every hour,
    /// but you can use this action when you want to get the latest metadata right
    /// away.
    pub fn resetConnectorMetadataCache(self: *Self, allocator: std.mem.Allocator, input: reset_connector_metadata_cache.ResetConnectorMetadataCacheInput, options: CallOptions) !reset_connector_metadata_cache.ResetConnectorMetadataCacheOutput {
        return reset_connector_metadata_cache.execute(self, allocator, input, options);
    }

    /// Activates an existing flow. For on-demand flows, this operation runs the
    /// flow
    /// immediately. For schedule and event-triggered flows, this operation
    /// activates the flow.
    pub fn startFlow(self: *Self, allocator: std.mem.Allocator, input: start_flow.StartFlowInput, options: CallOptions) !start_flow.StartFlowOutput {
        return start_flow.execute(self, allocator, input, options);
    }

    /// Deactivates the existing flow. For on-demand flows, this operation returns
    /// an
    /// `unsupportedOperationException` error message. For schedule and
    /// event-triggered
    /// flows, this operation deactivates the flow.
    pub fn stopFlow(self: *Self, allocator: std.mem.Allocator, input: stop_flow.StopFlowInput, options: CallOptions) !stop_flow.StopFlowOutput {
        return stop_flow.execute(self, allocator, input, options);
    }

    /// Applies a tag to the specified flow.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Unregisters the custom connector registered in your account that matches the
    /// connector
    /// label provided in the request.
    pub fn unregisterConnector(self: *Self, allocator: std.mem.Allocator, input: unregister_connector.UnregisterConnectorInput, options: CallOptions) !unregister_connector.UnregisterConnectorOutput {
        return unregister_connector.execute(self, allocator, input, options);
    }

    /// Removes a tag from the specified flow.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a given connector profile associated with your account.
    pub fn updateConnectorProfile(self: *Self, allocator: std.mem.Allocator, input: update_connector_profile.UpdateConnectorProfileInput, options: CallOptions) !update_connector_profile.UpdateConnectorProfileOutput {
        return update_connector_profile.execute(self, allocator, input, options);
    }

    /// Updates a custom connector that you've previously registered. This operation
    /// updates the
    /// connector with one of the following:
    ///
    /// * The latest version of the AWS Lambda function that's assigned to the
    ///   connector
    ///
    /// * A new AWS Lambda function that you specify
    pub fn updateConnectorRegistration(self: *Self, allocator: std.mem.Allocator, input: update_connector_registration.UpdateConnectorRegistrationInput, options: CallOptions) !update_connector_registration.UpdateConnectorRegistrationOutput {
        return update_connector_registration.execute(self, allocator, input, options);
    }

    /// Updates an existing flow.
    pub fn updateFlow(self: *Self, allocator: std.mem.Allocator, input: update_flow.UpdateFlowInput, options: CallOptions) !update_flow.UpdateFlowOutput {
        return update_flow.execute(self, allocator, input, options);
    }

    pub fn describeConnectorProfilesPaginator(self: *Self, params: describe_connector_profiles.DescribeConnectorProfilesInput) paginator.DescribeConnectorProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeConnectorsPaginator(self: *Self, params: describe_connectors.DescribeConnectorsInput) paginator.DescribeConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeFlowExecutionRecordsPaginator(self: *Self, params: describe_flow_execution_records.DescribeFlowExecutionRecordsInput) paginator.DescribeFlowExecutionRecordsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConnectorsPaginator(self: *Self, params: list_connectors.ListConnectorsInput) paginator.ListConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFlowsPaginator(self: *Self, params: list_flows.ListFlowsInput) paginator.ListFlowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
