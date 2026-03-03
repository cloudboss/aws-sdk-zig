const aws = @import("aws");
const std = @import("std");

const batch_get_user_access_tasks = @import("batch_get_user_access_tasks.zig");
const connect_app_authorization = @import("connect_app_authorization.zig");
const create_app_authorization = @import("create_app_authorization.zig");
const create_app_bundle = @import("create_app_bundle.zig");
const create_ingestion = @import("create_ingestion.zig");
const create_ingestion_destination = @import("create_ingestion_destination.zig");
const delete_app_authorization = @import("delete_app_authorization.zig");
const delete_app_bundle = @import("delete_app_bundle.zig");
const delete_ingestion = @import("delete_ingestion.zig");
const delete_ingestion_destination = @import("delete_ingestion_destination.zig");
const get_app_authorization = @import("get_app_authorization.zig");
const get_app_bundle = @import("get_app_bundle.zig");
const get_ingestion = @import("get_ingestion.zig");
const get_ingestion_destination = @import("get_ingestion_destination.zig");
const list_app_authorizations = @import("list_app_authorizations.zig");
const list_app_bundles = @import("list_app_bundles.zig");
const list_ingestion_destinations = @import("list_ingestion_destinations.zig");
const list_ingestions = @import("list_ingestions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_ingestion = @import("start_ingestion.zig");
const start_user_access_tasks = @import("start_user_access_tasks.zig");
const stop_ingestion = @import("stop_ingestion.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_app_authorization = @import("update_app_authorization.zig");
const update_ingestion_destination = @import("update_ingestion_destination.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AppFabric";

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

    /// Gets user access details in a batch request.
    ///
    /// This action polls data from the tasks that are kicked off by the
    /// `StartUserAccessTasks` action.
    pub fn batchGetUserAccessTasks(self: *Self, allocator: std.mem.Allocator, input: batch_get_user_access_tasks.BatchGetUserAccessTasksInput, options: CallOptions) !batch_get_user_access_tasks.BatchGetUserAccessTasksOutput {
        return batch_get_user_access_tasks.execute(self, allocator, input, options);
    }

    /// Establishes a connection between Amazon Web Services AppFabric and an
    /// application, which allows AppFabric to
    /// call the APIs of the application.
    pub fn connectAppAuthorization(self: *Self, allocator: std.mem.Allocator, input: connect_app_authorization.ConnectAppAuthorizationInput, options: CallOptions) !connect_app_authorization.ConnectAppAuthorizationOutput {
        return connect_app_authorization.execute(self, allocator, input, options);
    }

    /// Creates an app authorization within an app bundle, which allows AppFabric to
    /// connect to an
    /// application.
    pub fn createAppAuthorization(self: *Self, allocator: std.mem.Allocator, input: create_app_authorization.CreateAppAuthorizationInput, options: CallOptions) !create_app_authorization.CreateAppAuthorizationOutput {
        return create_app_authorization.execute(self, allocator, input, options);
    }

    /// Creates an app bundle to collect data from an application using AppFabric.
    pub fn createAppBundle(self: *Self, allocator: std.mem.Allocator, input: create_app_bundle.CreateAppBundleInput, options: CallOptions) !create_app_bundle.CreateAppBundleOutput {
        return create_app_bundle.execute(self, allocator, input, options);
    }

    /// Creates a data ingestion for an application.
    pub fn createIngestion(self: *Self, allocator: std.mem.Allocator, input: create_ingestion.CreateIngestionInput, options: CallOptions) !create_ingestion.CreateIngestionOutput {
        return create_ingestion.execute(self, allocator, input, options);
    }

    /// Creates an ingestion destination, which specifies how an application's
    /// ingested data is
    /// processed by Amazon Web Services AppFabric and where it's delivered.
    pub fn createIngestionDestination(self: *Self, allocator: std.mem.Allocator, input: create_ingestion_destination.CreateIngestionDestinationInput, options: CallOptions) !create_ingestion_destination.CreateIngestionDestinationOutput {
        return create_ingestion_destination.execute(self, allocator, input, options);
    }

    /// Deletes an app authorization. You must delete the associated ingestion
    /// before you can
    /// delete an app authorization.
    pub fn deleteAppAuthorization(self: *Self, allocator: std.mem.Allocator, input: delete_app_authorization.DeleteAppAuthorizationInput, options: CallOptions) !delete_app_authorization.DeleteAppAuthorizationOutput {
        return delete_app_authorization.execute(self, allocator, input, options);
    }

    /// Deletes an app bundle. You must delete all associated app authorizations
    /// before you can
    /// delete an app bundle.
    pub fn deleteAppBundle(self: *Self, allocator: std.mem.Allocator, input: delete_app_bundle.DeleteAppBundleInput, options: CallOptions) !delete_app_bundle.DeleteAppBundleOutput {
        return delete_app_bundle.execute(self, allocator, input, options);
    }

    /// Deletes an ingestion. You must stop (disable) the ingestion and you must
    /// delete all
    /// associated ingestion destinations before you can delete an app ingestion.
    pub fn deleteIngestion(self: *Self, allocator: std.mem.Allocator, input: delete_ingestion.DeleteIngestionInput, options: CallOptions) !delete_ingestion.DeleteIngestionOutput {
        return delete_ingestion.execute(self, allocator, input, options);
    }

    /// Deletes an ingestion destination.
    ///
    /// This deletes the association between an ingestion and it's destination. It
    /// doesn't
    /// delete previously ingested data or the storage destination, such as the
    /// Amazon S3
    /// bucket where the data is delivered. If the ingestion destination is deleted
    /// while the
    /// associated ingestion is enabled, the ingestion will fail and is eventually
    /// disabled.
    pub fn deleteIngestionDestination(self: *Self, allocator: std.mem.Allocator, input: delete_ingestion_destination.DeleteIngestionDestinationInput, options: CallOptions) !delete_ingestion_destination.DeleteIngestionDestinationOutput {
        return delete_ingestion_destination.execute(self, allocator, input, options);
    }

    /// Returns information about an app authorization.
    pub fn getAppAuthorization(self: *Self, allocator: std.mem.Allocator, input: get_app_authorization.GetAppAuthorizationInput, options: CallOptions) !get_app_authorization.GetAppAuthorizationOutput {
        return get_app_authorization.execute(self, allocator, input, options);
    }

    /// Returns information about an app bundle.
    pub fn getAppBundle(self: *Self, allocator: std.mem.Allocator, input: get_app_bundle.GetAppBundleInput, options: CallOptions) !get_app_bundle.GetAppBundleOutput {
        return get_app_bundle.execute(self, allocator, input, options);
    }

    /// Returns information about an ingestion.
    pub fn getIngestion(self: *Self, allocator: std.mem.Allocator, input: get_ingestion.GetIngestionInput, options: CallOptions) !get_ingestion.GetIngestionOutput {
        return get_ingestion.execute(self, allocator, input, options);
    }

    /// Returns information about an ingestion destination.
    pub fn getIngestionDestination(self: *Self, allocator: std.mem.Allocator, input: get_ingestion_destination.GetIngestionDestinationInput, options: CallOptions) !get_ingestion_destination.GetIngestionDestinationOutput {
        return get_ingestion_destination.execute(self, allocator, input, options);
    }

    /// Returns a list of all app authorizations configured for an app bundle.
    pub fn listAppAuthorizations(self: *Self, allocator: std.mem.Allocator, input: list_app_authorizations.ListAppAuthorizationsInput, options: CallOptions) !list_app_authorizations.ListAppAuthorizationsOutput {
        return list_app_authorizations.execute(self, allocator, input, options);
    }

    /// Returns a list of app bundles.
    pub fn listAppBundles(self: *Self, allocator: std.mem.Allocator, input: list_app_bundles.ListAppBundlesInput, options: CallOptions) !list_app_bundles.ListAppBundlesOutput {
        return list_app_bundles.execute(self, allocator, input, options);
    }

    /// Returns a list of all ingestion destinations configured for an ingestion.
    pub fn listIngestionDestinations(self: *Self, allocator: std.mem.Allocator, input: list_ingestion_destinations.ListIngestionDestinationsInput, options: CallOptions) !list_ingestion_destinations.ListIngestionDestinationsOutput {
        return list_ingestion_destinations.execute(self, allocator, input, options);
    }

    /// Returns a list of all ingestions configured for an app bundle.
    pub fn listIngestions(self: *Self, allocator: std.mem.Allocator, input: list_ingestions.ListIngestionsInput, options: CallOptions) !list_ingestions.ListIngestionsOutput {
        return list_ingestions.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts (enables) an ingestion, which collects data from an application.
    pub fn startIngestion(self: *Self, allocator: std.mem.Allocator, input: start_ingestion.StartIngestionInput, options: CallOptions) !start_ingestion.StartIngestionOutput {
        return start_ingestion.execute(self, allocator, input, options);
    }

    /// Starts the tasks to search user access status for a specific email address.
    ///
    /// The tasks are stopped when the user access status data is found. The tasks
    /// are
    /// terminated when the API calls to the application time out.
    pub fn startUserAccessTasks(self: *Self, allocator: std.mem.Allocator, input: start_user_access_tasks.StartUserAccessTasksInput, options: CallOptions) !start_user_access_tasks.StartUserAccessTasksOutput {
        return start_user_access_tasks.execute(self, allocator, input, options);
    }

    /// Stops (disables) an ingestion.
    pub fn stopIngestion(self: *Self, allocator: std.mem.Allocator, input: stop_ingestion.StopIngestionInput, options: CallOptions) !stop_ingestion.StopIngestionOutput {
        return stop_ingestion.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an app authorization within an app bundle, which allows AppFabric to
    /// connect to an
    /// application.
    ///
    /// If the app authorization was in a `connected` state, updating the app
    /// authorization will set it back to a `PendingConnect` state.
    pub fn updateAppAuthorization(self: *Self, allocator: std.mem.Allocator, input: update_app_authorization.UpdateAppAuthorizationInput, options: CallOptions) !update_app_authorization.UpdateAppAuthorizationOutput {
        return update_app_authorization.execute(self, allocator, input, options);
    }

    /// Updates an ingestion destination, which specifies how an application's
    /// ingested data is
    /// processed by Amazon Web Services AppFabric and where it's delivered.
    pub fn updateIngestionDestination(self: *Self, allocator: std.mem.Allocator, input: update_ingestion_destination.UpdateIngestionDestinationInput, options: CallOptions) !update_ingestion_destination.UpdateIngestionDestinationOutput {
        return update_ingestion_destination.execute(self, allocator, input, options);
    }

    pub fn listAppAuthorizationsPaginator(self: *Self, params: list_app_authorizations.ListAppAuthorizationsInput) paginator.ListAppAuthorizationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAppBundlesPaginator(self: *Self, params: list_app_bundles.ListAppBundlesInput) paginator.ListAppBundlesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIngestionDestinationsPaginator(self: *Self, params: list_ingestion_destinations.ListIngestionDestinationsInput) paginator.ListIngestionDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIngestionsPaginator(self: *Self, params: list_ingestions.ListIngestionsInput) paginator.ListIngestionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
