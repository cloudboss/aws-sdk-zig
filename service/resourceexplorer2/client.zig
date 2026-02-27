const aws = @import("aws");
const std = @import("std");

const associate_default_view = @import("associate_default_view.zig");
const batch_get_view = @import("batch_get_view.zig");
const create_index = @import("create_index.zig");
const create_resource_explorer_setup = @import("create_resource_explorer_setup.zig");
const create_view = @import("create_view.zig");
const delete_index = @import("delete_index.zig");
const delete_resource_explorer_setup = @import("delete_resource_explorer_setup.zig");
const delete_view = @import("delete_view.zig");
const disassociate_default_view = @import("disassociate_default_view.zig");
const get_account_level_service_configuration = @import("get_account_level_service_configuration.zig");
const get_default_view = @import("get_default_view.zig");
const get_index = @import("get_index.zig");
const get_managed_view = @import("get_managed_view.zig");
const get_resource_explorer_setup = @import("get_resource_explorer_setup.zig");
const get_service_index = @import("get_service_index.zig");
const get_service_view = @import("get_service_view.zig");
const get_view = @import("get_view.zig");
const list_indexes = @import("list_indexes.zig");
const list_indexes_for_members = @import("list_indexes_for_members.zig");
const list_managed_views = @import("list_managed_views.zig");
const list_resources = @import("list_resources.zig");
const list_service_indexes = @import("list_service_indexes.zig");
const list_service_views = @import("list_service_views.zig");
const list_streaming_access_for_services = @import("list_streaming_access_for_services.zig");
const list_supported_resource_types = @import("list_supported_resource_types.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_views = @import("list_views.zig");
const search_ = @import("search.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_index_type = @import("update_index_type.zig");
const update_view = @import("update_view.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Resource Explorer 2";

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

    /// Sets the specified view as the default for the Amazon Web Services Region in
    /// which you call this operation. When a user performs a Search that doesn't
    /// explicitly specify which view to use, then Amazon Web Services Resource
    /// Explorer automatically chooses this default view for searches performed in
    /// this Amazon Web Services Region.
    ///
    /// If an Amazon Web Services Region doesn't have a default view configured,
    /// then users must explicitly specify a view with every `Search` operation
    /// performed in that Region.
    pub fn associateDefaultView(self: *Self, allocator: std.mem.Allocator, input: associate_default_view.AssociateDefaultViewInput, options: associate_default_view.Options) !associate_default_view.AssociateDefaultViewOutput {
        return associate_default_view.execute(self, allocator, input, options);
    }

    /// Retrieves details about a list of views.
    pub fn batchGetView(self: *Self, allocator: std.mem.Allocator, input: batch_get_view.BatchGetViewInput, options: batch_get_view.Options) !batch_get_view.BatchGetViewOutput {
        return batch_get_view.execute(self, allocator, input, options);
    }

    /// Turns on Amazon Web Services Resource Explorer in the Amazon Web Services
    /// Region in which you called this operation by creating an index. Resource
    /// Explorer begins discovering the resources in this Region and stores the
    /// details about the resources in the index so that they can be queried by
    /// using the Search operation. You can create only one index in a Region.
    ///
    /// This operation creates only a *local* index. To promote the local index in
    /// one Amazon Web Services Region into the aggregator index for the Amazon Web
    /// Services account, use the UpdateIndexType operation. For more information,
    /// see [Turning on cross-Region search by creating an aggregator
    /// index](https://docs.aws.amazon.com/resource-explorer/latest/userguide/manage-aggregator-region.html) in the *Amazon Web Services Resource Explorer User Guide*.
    ///
    /// For more details about what happens when you turn on Resource Explorer in an
    /// Amazon Web Services Region, see [Turn on Resource Explorer to index your
    /// resources in an Amazon Web Services
    /// Region](https://docs.aws.amazon.com/resource-explorer/latest/userguide/manage-service-activate.html) in the *Amazon Web Services Resource Explorer User Guide*.
    ///
    /// If this is the first Amazon Web Services Region in which you've created an
    /// index for Resource Explorer, then this operation also [creates a
    /// service-linked
    /// role](https://docs.aws.amazon.com/resource-explorer/latest/userguide/security_iam_service-linked-roles.html) in your Amazon Web Services account that allows Resource Explorer to enumerate your resources to populate the index.
    ///
    /// * **Action**: `resource-explorer-2:CreateIndex`
    ///
    /// **Resource**: The ARN of the index (as it will exist after the operation
    /// completes) in the Amazon Web Services Region and account in which you're
    /// trying to create the index. Use the wildcard character (`*`) at the end of
    /// the string to match the eventual UUID. For example, the following `Resource`
    /// element restricts the role or user to creating an index in only the
    /// `us-east-2` Region of the specified account.
    ///
    /// `"Resource": "arn:aws:resource-explorer-2:us-west-2:*<account-id>*:index/*"`
    ///
    /// Alternatively, you can use `"Resource": "*"` to allow the role or user to
    /// create an index in any Region.
    /// * **Action**: `iam:CreateServiceLinkedRole`
    ///
    /// **Resource**: No specific resource (*).
    ///
    /// This permission is required only the first time you create an index to turn
    /// on Resource Explorer in the account. Resource Explorer uses this to create
    /// the [service-linked role needed to index the resources in your
    /// account](https://docs.aws.amazon.com/resource-explorer/latest/userguide/security_iam_service-linked-roles.html). Resource Explorer uses the same service-linked role for all additional indexes you create afterwards.
    pub fn createIndex(self: *Self, allocator: std.mem.Allocator, input: create_index.CreateIndexInput, options: create_index.Options) !create_index.CreateIndexOutput {
        return create_index.execute(self, allocator, input, options);
    }

    /// Creates a Resource Explorer setup configuration across multiple Amazon Web
    /// Services Regions. This operation sets up indexes and views in the specified
    /// Regions. This operation can also be used to set an aggregator Region for
    /// cross-Region resource search.
    pub fn createResourceExplorerSetup(self: *Self, allocator: std.mem.Allocator, input: create_resource_explorer_setup.CreateResourceExplorerSetupInput, options: create_resource_explorer_setup.Options) !create_resource_explorer_setup.CreateResourceExplorerSetupOutput {
        return create_resource_explorer_setup.execute(self, allocator, input, options);
    }

    /// Creates a view that users can query by using the Search operation. Results
    /// from queries that you make using this view include only resources that match
    /// the view's `Filters`. For more information about Amazon Web Services
    /// Resource Explorer views, see [Managing
    /// views](https://docs.aws.amazon.com/resource-explorer/latest/userguide/manage-views.html) in the *Amazon Web Services Resource Explorer User Guide*.
    ///
    /// Only the principals with an IAM identity-based policy that grants `Allow` to
    /// the `Search` action on a `Resource` with the [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of this view can Search using views you create with this operation.
    pub fn createView(self: *Self, allocator: std.mem.Allocator, input: create_view.CreateViewInput, options: create_view.Options) !create_view.CreateViewOutput {
        return create_view.execute(self, allocator, input, options);
    }

    /// Deletes the specified index and turns off Amazon Web Services Resource
    /// Explorer in the specified Amazon Web Services Region. When you delete an
    /// index, Resource Explorer stops discovering and indexing resources in that
    /// Region. Resource Explorer also deletes all views in that Region. These
    /// actions occur as asynchronous background tasks. You can check to see when
    /// the actions are complete by using the GetIndex operation and checking the
    /// `Status` response value.
    ///
    /// If the index you delete is the aggregator index for the Amazon Web Services
    /// account, you must wait 24 hours before you can promote another local index
    /// to be the aggregator index for the account. Users can't perform account-wide
    /// searches using Resource Explorer until another aggregator index is
    /// configured.
    pub fn deleteIndex(self: *Self, allocator: std.mem.Allocator, input: delete_index.DeleteIndexInput, options: delete_index.Options) !delete_index.DeleteIndexOutput {
        return delete_index.execute(self, allocator, input, options);
    }

    /// Deletes a Resource Explorer setup configuration. This operation removes
    /// indexes and views from the specified Regions or all Regions where Resource
    /// Explorer is configured.
    pub fn deleteResourceExplorerSetup(self: *Self, allocator: std.mem.Allocator, input: delete_resource_explorer_setup.DeleteResourceExplorerSetupInput, options: delete_resource_explorer_setup.Options) !delete_resource_explorer_setup.DeleteResourceExplorerSetupOutput {
        return delete_resource_explorer_setup.execute(self, allocator, input, options);
    }

    /// Deletes the specified view.
    ///
    /// If the specified view is the default view for its Amazon Web Services
    /// Region, then all Search operations in that Region must explicitly specify
    /// the view to use until you configure a new default by calling the
    /// AssociateDefaultView operation.
    pub fn deleteView(self: *Self, allocator: std.mem.Allocator, input: delete_view.DeleteViewInput, options: delete_view.Options) !delete_view.DeleteViewOutput {
        return delete_view.execute(self, allocator, input, options);
    }

    /// After you call this operation, the affected Amazon Web Services Region no
    /// longer has a default view. All Search operations in that Region must
    /// explicitly specify a view or the operation fails. You can configure a new
    /// default by calling the AssociateDefaultView operation.
    ///
    /// If an Amazon Web Services Region doesn't have a default view configured,
    /// then users must explicitly specify a view with every `Search` operation
    /// performed in that Region.
    pub fn disassociateDefaultView(self: *Self, allocator: std.mem.Allocator, input: disassociate_default_view.DisassociateDefaultViewInput, options: disassociate_default_view.Options) !disassociate_default_view.DisassociateDefaultViewOutput {
        return disassociate_default_view.execute(self, allocator, input, options);
    }

    /// Retrieves the status of your account's Amazon Web Services service access,
    /// and validates the service linked role required to access the multi-account
    /// search feature. Only the management account can invoke this API call.
    pub fn getAccountLevelServiceConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_account_level_service_configuration.GetAccountLevelServiceConfigurationInput, options: get_account_level_service_configuration.Options) !get_account_level_service_configuration.GetAccountLevelServiceConfigurationOutput {
        return get_account_level_service_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the Amazon Resource Name (ARN) of the view that is the default for
    /// the Amazon Web Services Region in which you call this operation. You can
    /// then call GetView to retrieve the details of that view.
    pub fn getDefaultView(self: *Self, allocator: std.mem.Allocator, input: get_default_view.GetDefaultViewInput, options: get_default_view.Options) !get_default_view.GetDefaultViewOutput {
        return get_default_view.execute(self, allocator, input, options);
    }

    /// Retrieves details about the Amazon Web Services Resource Explorer index in
    /// the Amazon Web Services Region in which you invoked the operation.
    pub fn getIndex(self: *Self, allocator: std.mem.Allocator, input: get_index.GetIndexInput, options: get_index.Options) !get_index.GetIndexOutput {
        return get_index.execute(self, allocator, input, options);
    }

    /// Retrieves details of the specified [Amazon Web Services-managed
    /// view](https://docs.aws.amazon.com/resource-explorer/latest/userguide/aws-managed-views.html).
    pub fn getManagedView(self: *Self, allocator: std.mem.Allocator, input: get_managed_view.GetManagedViewInput, options: get_managed_view.Options) !get_managed_view.GetManagedViewOutput {
        return get_managed_view.execute(self, allocator, input, options);
    }

    /// Retrieves the status and details of a Resource Explorer setup operation.
    /// This operation returns information about the progress of creating or
    /// deleting Resource Explorer configurations across Regions.
    pub fn getResourceExplorerSetup(self: *Self, allocator: std.mem.Allocator, input: get_resource_explorer_setup.GetResourceExplorerSetupInput, options: get_resource_explorer_setup.Options) !get_resource_explorer_setup.GetResourceExplorerSetupOutput {
        return get_resource_explorer_setup.execute(self, allocator, input, options);
    }

    /// Retrieves information about the Resource Explorer index in the current
    /// Amazon Web Services Region. This operation returns the ARN and type of the
    /// index if one exists.
    pub fn getServiceIndex(self: *Self, allocator: std.mem.Allocator, input: get_service_index.GetServiceIndexInput, options: get_service_index.Options) !get_service_index.GetServiceIndexOutput {
        return get_service_index.execute(self, allocator, input, options);
    }

    /// Retrieves details about a specific Resource Explorer service view. This
    /// operation returns the configuration and properties of the specified view.
    pub fn getServiceView(self: *Self, allocator: std.mem.Allocator, input: get_service_view.GetServiceViewInput, options: get_service_view.Options) !get_service_view.GetServiceViewOutput {
        return get_service_view.execute(self, allocator, input, options);
    }

    /// Retrieves details of the specified view.
    pub fn getView(self: *Self, allocator: std.mem.Allocator, input: get_view.GetViewInput, options: get_view.Options) !get_view.GetViewOutput {
        return get_view.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all of the indexes in Amazon Web Services Regions that
    /// are currently collecting resource information for Amazon Web Services
    /// Resource Explorer.
    pub fn listIndexes(self: *Self, allocator: std.mem.Allocator, input: list_indexes.ListIndexesInput, options: list_indexes.Options) !list_indexes.ListIndexesOutput {
        return list_indexes.execute(self, allocator, input, options);
    }

    /// Retrieves a list of a member's indexes in all Amazon Web Services Regions
    /// that are currently collecting resource information for Amazon Web Services
    /// Resource Explorer. Only the management account or a delegated administrator
    /// with service access enabled can invoke this API call.
    pub fn listIndexesForMembers(self: *Self, allocator: std.mem.Allocator, input: list_indexes_for_members.ListIndexesForMembersInput, options: list_indexes_for_members.Options) !list_indexes_for_members.ListIndexesForMembersOutput {
        return list_indexes_for_members.execute(self, allocator, input, options);
    }

    /// Lists the Amazon resource names (ARNs) of the [Amazon Web Services-managed
    /// views](https://docs.aws.amazon.com/resource-explorer/latest/userguide/aws-managed-views.html) available in the Amazon Web Services Region in which you call this operation.
    pub fn listManagedViews(self: *Self, allocator: std.mem.Allocator, input: list_managed_views.ListManagedViewsInput, options: list_managed_views.Options) !list_managed_views.ListManagedViewsOutput {
        return list_managed_views.execute(self, allocator, input, options);
    }

    /// Returns a list of resources and their details that match the specified
    /// criteria. This query must use a view. If you don’t explicitly specify a
    /// view, then Resource Explorer uses the default view for the Amazon Web
    /// Services Region in which you call this operation.
    pub fn listResources(self: *Self, allocator: std.mem.Allocator, input: list_resources.ListResourcesInput, options: list_resources.Options) !list_resources.ListResourcesOutput {
        return list_resources.execute(self, allocator, input, options);
    }

    /// Lists all Resource Explorer indexes across the specified Amazon Web Services
    /// Regions. This operation returns information about indexes including their
    /// ARNs, types, and Regions.
    pub fn listServiceIndexes(self: *Self, allocator: std.mem.Allocator, input: list_service_indexes.ListServiceIndexesInput, options: list_service_indexes.Options) !list_service_indexes.ListServiceIndexesOutput {
        return list_service_indexes.execute(self, allocator, input, options);
    }

    /// Lists all Resource Explorer service views available in the current Amazon
    /// Web Services account. This operation returns the ARNs of available service
    /// views.
    pub fn listServiceViews(self: *Self, allocator: std.mem.Allocator, input: list_service_views.ListServiceViewsInput, options: list_service_views.Options) !list_service_views.ListServiceViewsOutput {
        return list_service_views.execute(self, allocator, input, options);
    }

    /// Returns a list of Amazon Web Services services that have been granted
    /// streaming access to your Resource Explorer data. Streaming access allows
    /// Amazon Web Services services to receive real-time updates about your
    /// resources as they are indexed by Resource Explorer.
    pub fn listStreamingAccessForServices(self: *Self, allocator: std.mem.Allocator, input: list_streaming_access_for_services.ListStreamingAccessForServicesInput, options: list_streaming_access_for_services.Options) !list_streaming_access_for_services.ListStreamingAccessForServicesOutput {
        return list_streaming_access_for_services.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all resource types currently supported by Amazon Web
    /// Services Resource Explorer.
    pub fn listSupportedResourceTypes(self: *Self, allocator: std.mem.Allocator, input: list_supported_resource_types.ListSupportedResourceTypesInput, options: list_supported_resource_types.Options) !list_supported_resource_types.ListSupportedResourceTypesOutput {
        return list_supported_resource_types.execute(self, allocator, input, options);
    }

    /// Lists the tags that are attached to the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the [Amazon resource names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the views available in the Amazon Web Services Region in which you call this operation.
    ///
    /// Always check the `NextToken` response parameter for a `null` value when
    /// calling a paginated operation. These operations can occasionally return an
    /// empty set of results even when there are more results available. The
    /// `NextToken` response parameter value is `null` *only* when there are no more
    /// results to display.
    pub fn listViews(self: *Self, allocator: std.mem.Allocator, input: list_views.ListViewsInput, options: list_views.Options) !list_views.ListViewsOutput {
        return list_views.execute(self, allocator, input, options);
    }

    /// Searches for resources and displays details about all resources that match
    /// the specified criteria. You must specify a query string.
    ///
    /// All search queries must use a view. If you don't explicitly specify a view,
    /// then Amazon Web Services Resource Explorer uses the default view for the
    /// Amazon Web Services Region in which you call this operation. The results are
    /// the logical intersection of the results that match both the `QueryString`
    /// parameter supplied to this operation and the `SearchFilter` parameter
    /// attached to the view.
    ///
    /// For the complete syntax supported by the `QueryString` parameter, see
    /// [Search query syntax reference for Resource
    /// Explorer](https://docs.aws.amazon.com/resource-explorer/latest/APIReference/about-query-syntax.html).
    ///
    /// If your search results are empty, or are missing results that you think
    /// should be there, see [Troubleshooting Resource Explorer
    /// search](https://docs.aws.amazon.com/resource-explorer/latest/userguide/troubleshooting_search.html).
    pub fn search(self: *Self, allocator: std.mem.Allocator, input: search_.SearchInput, options: search_.Options) !search_.SearchOutput {
        return search_.execute(self, allocator, input, options);
    }

    /// Adds one or more tag key and value pairs to an Amazon Web Services Resource
    /// Explorer view or index.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tag key and value pairs from an Amazon Web Services
    /// Resource Explorer view or index.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Changes the type of the index from one of the following types to the other.
    /// For more information about indexes and the role they perform in Amazon Web
    /// Services Resource Explorer, see [Turning on cross-Region search by creating
    /// an aggregator
    /// index](https://docs.aws.amazon.com/resource-explorer/latest/userguide/manage-aggregator-region.html) in the *Amazon Web Services Resource Explorer User Guide*.
    ///
    /// * ** `AGGREGATOR` index type**
    ///
    /// The index contains information about resources from all Amazon Web Services
    /// Regions in the Amazon Web Services account in which you've created a
    /// Resource Explorer index. Resource information from all other Regions is
    /// replicated to this Region's index.
    ///
    /// When you change the index type to `AGGREGATOR`, Resource Explorer turns on
    /// replication of all discovered resource information from the other Amazon Web
    /// Services Regions in your account to this index. You can then, from this
    /// Region only, perform resource search queries that span all Amazon Web
    /// Services Regions in the Amazon Web Services account. Turning on replication
    /// from all other Regions is performed by asynchronous background tasks. You
    /// can check the status of the asynchronous tasks by using the GetIndex
    /// operation. When the asynchronous tasks complete, the `Status` response of
    /// that operation changes from `UPDATING` to `ACTIVE`. After that, you can
    /// start to see results from other Amazon Web Services Regions in query
    /// results. However, it can take several hours for replication from all other
    /// Regions to complete.
    ///
    /// You can have only one aggregator index per Amazon Web Services account.
    /// Before you can promote a different index to be the aggregator index for the
    /// account, you must first demote the existing aggregator index to type
    /// `LOCAL`.
    /// * ** `LOCAL` index type**
    ///
    /// The index contains information about resources in only the Amazon Web
    /// Services Region in which the index exists. If an aggregator index in another
    /// Region exists, then information in this local index is replicated to the
    /// aggregator index.
    ///
    /// When you change the index type to `LOCAL`, Resource Explorer turns off the
    /// replication of resource information from all other Amazon Web Services
    /// Regions in the Amazon Web Services account to this Region. The aggregator
    /// index remains in the `UPDATING` state until all replication with other
    /// Regions successfully stops. You can check the status of the asynchronous
    /// task by using the GetIndex operation. When Resource Explorer successfully
    /// stops all replication with other Regions, the `Status` response of that
    /// operation changes from `UPDATING` to `ACTIVE`. Separately, the resource
    /// information from other Regions that was previously stored in the index is
    /// deleted within 30 days by another background task. Until that asynchronous
    /// task completes, some results from other Regions can continue to appear in
    /// search results.
    ///
    /// After you demote an aggregator index to a local index, you must wait 24
    /// hours before you can promote another index to be the new aggregator index
    /// for the account.
    pub fn updateIndexType(self: *Self, allocator: std.mem.Allocator, input: update_index_type.UpdateIndexTypeInput, options: update_index_type.Options) !update_index_type.UpdateIndexTypeOutput {
        return update_index_type.execute(self, allocator, input, options);
    }

    /// Modifies some of the details of a view. You can change the filter string and
    /// the list of included properties. You can't change the name of the view.
    pub fn updateView(self: *Self, allocator: std.mem.Allocator, input: update_view.UpdateViewInput, options: update_view.Options) !update_view.UpdateViewOutput {
        return update_view.execute(self, allocator, input, options);
    }

    pub fn getResourceExplorerSetupPaginator(self: *Self, params: get_resource_explorer_setup.GetResourceExplorerSetupInput) paginator.GetResourceExplorerSetupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIndexesPaginator(self: *Self, params: list_indexes.ListIndexesInput) paginator.ListIndexesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIndexesForMembersPaginator(self: *Self, params: list_indexes_for_members.ListIndexesForMembersInput) paginator.ListIndexesForMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedViewsPaginator(self: *Self, params: list_managed_views.ListManagedViewsInput) paginator.ListManagedViewsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcesPaginator(self: *Self, params: list_resources.ListResourcesInput) paginator.ListResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceIndexesPaginator(self: *Self, params: list_service_indexes.ListServiceIndexesInput) paginator.ListServiceIndexesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceViewsPaginator(self: *Self, params: list_service_views.ListServiceViewsInput) paginator.ListServiceViewsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamingAccessForServicesPaginator(self: *Self, params: list_streaming_access_for_services.ListStreamingAccessForServicesInput) paginator.ListStreamingAccessForServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSupportedResourceTypesPaginator(self: *Self, params: list_supported_resource_types.ListSupportedResourceTypesInput) paginator.ListSupportedResourceTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listViewsPaginator(self: *Self, params: list_views.ListViewsInput) paginator.ListViewsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchPaginator(self: *Self, params: search_.SearchInput) paginator.SearchPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
