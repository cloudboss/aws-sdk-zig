const aws = @import("aws");
const std = @import("std");

const cancel_capacity_task = @import("cancel_capacity_task.zig");
const cancel_order = @import("cancel_order.zig");
const create_order = @import("create_order.zig");
const create_outpost = @import("create_outpost.zig");
const create_site = @import("create_site.zig");
const delete_outpost = @import("delete_outpost.zig");
const delete_site = @import("delete_site.zig");
const get_capacity_task = @import("get_capacity_task.zig");
const get_catalog_item = @import("get_catalog_item.zig");
const get_connection = @import("get_connection.zig");
const get_order = @import("get_order.zig");
const get_outpost = @import("get_outpost.zig");
const get_outpost_billing_information = @import("get_outpost_billing_information.zig");
const get_outpost_instance_types = @import("get_outpost_instance_types.zig");
const get_outpost_supported_instance_types = @import("get_outpost_supported_instance_types.zig");
const get_site = @import("get_site.zig");
const get_site_address = @import("get_site_address.zig");
const list_asset_instances = @import("list_asset_instances.zig");
const list_assets = @import("list_assets.zig");
const list_blocking_instances_for_capacity_task = @import("list_blocking_instances_for_capacity_task.zig");
const list_capacity_tasks = @import("list_capacity_tasks.zig");
const list_catalog_items = @import("list_catalog_items.zig");
const list_orders = @import("list_orders.zig");
const list_outposts = @import("list_outposts.zig");
const list_sites = @import("list_sites.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_capacity_task = @import("start_capacity_task.zig");
const start_connection = @import("start_connection.zig");
const start_outpost_decommission = @import("start_outpost_decommission.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_outpost = @import("update_outpost.zig");
const update_site = @import("update_site.zig");
const update_site_address = @import("update_site_address.zig");
const update_site_rack_physical_properties = @import("update_site_rack_physical_properties.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Outposts";

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

    /// Cancels the capacity task.
    pub fn cancelCapacityTask(self: *Self, allocator: std.mem.Allocator, input: cancel_capacity_task.CancelCapacityTaskInput, options: CallOptions) !cancel_capacity_task.CancelCapacityTaskOutput {
        return cancel_capacity_task.execute(self, allocator, input, options);
    }

    /// Cancels the specified order for an Outpost.
    pub fn cancelOrder(self: *Self, allocator: std.mem.Allocator, input: cancel_order.CancelOrderInput, options: CallOptions) !cancel_order.CancelOrderOutput {
        return cancel_order.execute(self, allocator, input, options);
    }

    /// Creates an order for an Outpost.
    pub fn createOrder(self: *Self, allocator: std.mem.Allocator, input: create_order.CreateOrderInput, options: CallOptions) !create_order.CreateOrderOutput {
        return create_order.execute(self, allocator, input, options);
    }

    /// Creates an Outpost.
    ///
    /// You can specify either an Availability one or an AZ ID.
    pub fn createOutpost(self: *Self, allocator: std.mem.Allocator, input: create_outpost.CreateOutpostInput, options: CallOptions) !create_outpost.CreateOutpostOutput {
        return create_outpost.execute(self, allocator, input, options);
    }

    /// Creates a site for an Outpost.
    pub fn createSite(self: *Self, allocator: std.mem.Allocator, input: create_site.CreateSiteInput, options: CallOptions) !create_site.CreateSiteOutput {
        return create_site.execute(self, allocator, input, options);
    }

    /// Deletes the specified Outpost.
    pub fn deleteOutpost(self: *Self, allocator: std.mem.Allocator, input: delete_outpost.DeleteOutpostInput, options: CallOptions) !delete_outpost.DeleteOutpostOutput {
        return delete_outpost.execute(self, allocator, input, options);
    }

    /// Deletes the specified site.
    pub fn deleteSite(self: *Self, allocator: std.mem.Allocator, input: delete_site.DeleteSiteInput, options: CallOptions) !delete_site.DeleteSiteOutput {
        return delete_site.execute(self, allocator, input, options);
    }

    /// Gets details of the specified capacity task.
    pub fn getCapacityTask(self: *Self, allocator: std.mem.Allocator, input: get_capacity_task.GetCapacityTaskInput, options: CallOptions) !get_capacity_task.GetCapacityTaskOutput {
        return get_capacity_task.execute(self, allocator, input, options);
    }

    /// Gets information about the specified catalog item.
    pub fn getCatalogItem(self: *Self, allocator: std.mem.Allocator, input: get_catalog_item.GetCatalogItemInput, options: CallOptions) !get_catalog_item.GetCatalogItemOutput {
        return get_catalog_item.execute(self, allocator, input, options);
    }

    /// Amazon Web Services uses this action to install Outpost servers.
    ///
    /// Gets information about the specified connection.
    ///
    /// Use CloudTrail to monitor this action or Amazon Web Services managed policy
    /// for Amazon Web Services Outposts to secure it. For
    /// more information, see [
    /// Amazon Web Services managed policies for Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/outposts/latest/userguide/security-iam-awsmanpol.html) and [
    /// Logging Amazon Web Services Outposts API calls with Amazon Web Services
    /// CloudTrail](https://docs.aws.amazon.com/outposts/latest/userguide/logging-using-cloudtrail.html) in the *Amazon Web Services Outposts User Guide*.
    pub fn getConnection(self: *Self, allocator: std.mem.Allocator, input: get_connection.GetConnectionInput, options: CallOptions) !get_connection.GetConnectionOutput {
        return get_connection.execute(self, allocator, input, options);
    }

    /// Gets information about the specified order.
    pub fn getOrder(self: *Self, allocator: std.mem.Allocator, input: get_order.GetOrderInput, options: CallOptions) !get_order.GetOrderOutput {
        return get_order.execute(self, allocator, input, options);
    }

    /// Gets information about the specified Outpost.
    pub fn getOutpost(self: *Self, allocator: std.mem.Allocator, input: get_outpost.GetOutpostInput, options: CallOptions) !get_outpost.GetOutpostOutput {
        return get_outpost.execute(self, allocator, input, options);
    }

    /// Gets current and historical billing information about the specified Outpost.
    pub fn getOutpostBillingInformation(self: *Self, allocator: std.mem.Allocator, input: get_outpost_billing_information.GetOutpostBillingInformationInput, options: CallOptions) !get_outpost_billing_information.GetOutpostBillingInformationOutput {
        return get_outpost_billing_information.execute(self, allocator, input, options);
    }

    /// Gets the instance types for the specified Outpost.
    pub fn getOutpostInstanceTypes(self: *Self, allocator: std.mem.Allocator, input: get_outpost_instance_types.GetOutpostInstanceTypesInput, options: CallOptions) !get_outpost_instance_types.GetOutpostInstanceTypesOutput {
        return get_outpost_instance_types.execute(self, allocator, input, options);
    }

    /// Gets the instance types that an Outpost can support in
    /// `InstanceTypeCapacity`.
    /// This will generally include instance types that are not currently configured
    /// and therefore
    /// cannot be launched with the current Outpost capacity configuration.
    pub fn getOutpostSupportedInstanceTypes(self: *Self, allocator: std.mem.Allocator, input: get_outpost_supported_instance_types.GetOutpostSupportedInstanceTypesInput, options: CallOptions) !get_outpost_supported_instance_types.GetOutpostSupportedInstanceTypesOutput {
        return get_outpost_supported_instance_types.execute(self, allocator, input, options);
    }

    /// Gets information about the specified Outpost site.
    pub fn getSite(self: *Self, allocator: std.mem.Allocator, input: get_site.GetSiteInput, options: CallOptions) !get_site.GetSiteOutput {
        return get_site.execute(self, allocator, input, options);
    }

    /// Gets the site address of the specified site.
    pub fn getSiteAddress(self: *Self, allocator: std.mem.Allocator, input: get_site_address.GetSiteAddressInput, options: CallOptions) !get_site_address.GetSiteAddressOutput {
        return get_site_address.execute(self, allocator, input, options);
    }

    /// A list of Amazon EC2 instances, belonging to all accounts, running on the
    /// specified Outpost.
    /// Does not include Amazon EBS or Amazon S3 instances.
    pub fn listAssetInstances(self: *Self, allocator: std.mem.Allocator, input: list_asset_instances.ListAssetInstancesInput, options: CallOptions) !list_asset_instances.ListAssetInstancesOutput {
        return list_asset_instances.execute(self, allocator, input, options);
    }

    /// Lists the hardware assets for the specified Outpost.
    ///
    /// Use filters to return specific results. If you specify multiple filters, the
    /// results include only the resources that match
    /// all of the specified filters. For a filter where you can specify multiple
    /// values, the results include
    /// items that match any of the values that you specify for the filter.
    pub fn listAssets(self: *Self, allocator: std.mem.Allocator, input: list_assets.ListAssetsInput, options: CallOptions) !list_assets.ListAssetsOutput {
        return list_assets.execute(self, allocator, input, options);
    }

    /// A list of Amazon EC2 instances running on the Outpost and belonging to the
    /// account that
    /// initiated the capacity task. Use this list to specify the instances you
    /// cannot stop to free up
    /// capacity to run the capacity task.
    pub fn listBlockingInstancesForCapacityTask(self: *Self, allocator: std.mem.Allocator, input: list_blocking_instances_for_capacity_task.ListBlockingInstancesForCapacityTaskInput, options: CallOptions) !list_blocking_instances_for_capacity_task.ListBlockingInstancesForCapacityTaskOutput {
        return list_blocking_instances_for_capacity_task.execute(self, allocator, input, options);
    }

    /// Lists the capacity tasks for your Amazon Web Services account.
    ///
    /// Use filters to return specific results. If you specify multiple filters, the
    /// results include only the resources that match
    /// all of the specified filters. For a filter where you can specify multiple
    /// values, the results include
    /// items that match any of the values that you specify for the filter.
    pub fn listCapacityTasks(self: *Self, allocator: std.mem.Allocator, input: list_capacity_tasks.ListCapacityTasksInput, options: CallOptions) !list_capacity_tasks.ListCapacityTasksOutput {
        return list_capacity_tasks.execute(self, allocator, input, options);
    }

    /// Lists the items in the catalog.
    ///
    /// Use filters to return specific results. If you specify multiple filters, the
    /// results include only the resources that match
    /// all of the specified filters. For a filter where you can specify multiple
    /// values, the results include
    /// items that match any of the values that you specify for the filter.
    pub fn listCatalogItems(self: *Self, allocator: std.mem.Allocator, input: list_catalog_items.ListCatalogItemsInput, options: CallOptions) !list_catalog_items.ListCatalogItemsOutput {
        return list_catalog_items.execute(self, allocator, input, options);
    }

    /// Lists the Outpost orders for your Amazon Web Services account.
    pub fn listOrders(self: *Self, allocator: std.mem.Allocator, input: list_orders.ListOrdersInput, options: CallOptions) !list_orders.ListOrdersOutput {
        return list_orders.execute(self, allocator, input, options);
    }

    /// Lists the Outposts for your Amazon Web Services account.
    ///
    /// Use filters to return specific results. If you specify multiple filters, the
    /// results include only the resources that match
    /// all of the specified filters. For a filter where you can specify multiple
    /// values, the results include
    /// items that match any of the values that you specify for the filter.
    pub fn listOutposts(self: *Self, allocator: std.mem.Allocator, input: list_outposts.ListOutpostsInput, options: CallOptions) !list_outposts.ListOutpostsOutput {
        return list_outposts.execute(self, allocator, input, options);
    }

    /// Lists the Outpost sites for your Amazon Web Services account. Use filters to
    /// return specific
    /// results.
    ///
    /// Use filters to return specific results. If you specify multiple filters, the
    /// results include only the resources that match
    /// all of the specified filters. For a filter where you can specify multiple
    /// values, the results include
    /// items that match any of the values that you specify for the filter.
    pub fn listSites(self: *Self, allocator: std.mem.Allocator, input: list_sites.ListSitesInput, options: CallOptions) !list_sites.ListSitesOutput {
        return list_sites.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts the specified capacity task. You can have one active capacity task
    /// for each order
    /// and each Outpost.
    pub fn startCapacityTask(self: *Self, allocator: std.mem.Allocator, input: start_capacity_task.StartCapacityTaskInput, options: CallOptions) !start_capacity_task.StartCapacityTaskOutput {
        return start_capacity_task.execute(self, allocator, input, options);
    }

    /// Amazon Web Services uses this action to install Outpost servers.
    ///
    /// Starts the connection required for Outpost server installation.
    ///
    /// Use CloudTrail to monitor this action or Amazon Web Services managed policy
    /// for Amazon Web Services Outposts to secure it. For
    /// more information, see [
    /// Amazon Web Services managed policies for Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/outposts/latest/userguide/security-iam-awsmanpol.html) and [
    /// Logging Amazon Web Services Outposts API calls with Amazon Web Services
    /// CloudTrail](https://docs.aws.amazon.com/outposts/latest/userguide/logging-using-cloudtrail.html) in the *Amazon Web Services Outposts User Guide*.
    pub fn startConnection(self: *Self, allocator: std.mem.Allocator, input: start_connection.StartConnectionInput, options: CallOptions) !start_connection.StartConnectionOutput {
        return start_connection.execute(self, allocator, input, options);
    }

    /// Starts the decommission process to return the Outposts racks or servers.
    pub fn startOutpostDecommission(self: *Self, allocator: std.mem.Allocator, input: start_outpost_decommission.StartOutpostDecommissionInput, options: CallOptions) !start_outpost_decommission.StartOutpostDecommissionOutput {
        return start_outpost_decommission.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Outpost.
    pub fn updateOutpost(self: *Self, allocator: std.mem.Allocator, input: update_outpost.UpdateOutpostInput, options: CallOptions) !update_outpost.UpdateOutpostOutput {
        return update_outpost.execute(self, allocator, input, options);
    }

    /// Updates the specified site.
    pub fn updateSite(self: *Self, allocator: std.mem.Allocator, input: update_site.UpdateSiteInput, options: CallOptions) !update_site.UpdateSiteOutput {
        return update_site.execute(self, allocator, input, options);
    }

    /// Updates the address of the specified site.
    ///
    /// You can't update a site address if there is an order in progress. You must
    /// wait for the
    /// order to complete or cancel the order.
    ///
    /// You can update the operating address before you place an order at the site,
    /// or after all
    /// Outposts that belong to the site have been deactivated.
    pub fn updateSiteAddress(self: *Self, allocator: std.mem.Allocator, input: update_site_address.UpdateSiteAddressInput, options: CallOptions) !update_site_address.UpdateSiteAddressOutput {
        return update_site_address.execute(self, allocator, input, options);
    }

    /// Update the physical and logistical details for a rack at a site. For more
    /// information
    /// about hardware requirements for racks, see [Network
    /// readiness
    /// checklist](https://docs.aws.amazon.com/outposts/latest/userguide/outposts-requirements.html#checklist) in the Amazon Web Services Outposts User Guide.
    ///
    /// To update a rack at a site with an order of `IN_PROGRESS`, you must wait for
    /// the order to complete or cancel the order.
    pub fn updateSiteRackPhysicalProperties(self: *Self, allocator: std.mem.Allocator, input: update_site_rack_physical_properties.UpdateSiteRackPhysicalPropertiesInput, options: CallOptions) !update_site_rack_physical_properties.UpdateSiteRackPhysicalPropertiesOutput {
        return update_site_rack_physical_properties.execute(self, allocator, input, options);
    }

    pub fn getOutpostBillingInformationPaginator(self: *Self, params: get_outpost_billing_information.GetOutpostBillingInformationInput) paginator.GetOutpostBillingInformationPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getOutpostInstanceTypesPaginator(self: *Self, params: get_outpost_instance_types.GetOutpostInstanceTypesInput) paginator.GetOutpostInstanceTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getOutpostSupportedInstanceTypesPaginator(self: *Self, params: get_outpost_supported_instance_types.GetOutpostSupportedInstanceTypesInput) paginator.GetOutpostSupportedInstanceTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetInstancesPaginator(self: *Self, params: list_asset_instances.ListAssetInstancesInput) paginator.ListAssetInstancesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetsPaginator(self: *Self, params: list_assets.ListAssetsInput) paginator.ListAssetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBlockingInstancesForCapacityTaskPaginator(self: *Self, params: list_blocking_instances_for_capacity_task.ListBlockingInstancesForCapacityTaskInput) paginator.ListBlockingInstancesForCapacityTaskPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCapacityTasksPaginator(self: *Self, params: list_capacity_tasks.ListCapacityTasksInput) paginator.ListCapacityTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCatalogItemsPaginator(self: *Self, params: list_catalog_items.ListCatalogItemsInput) paginator.ListCatalogItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOrdersPaginator(self: *Self, params: list_orders.ListOrdersInput) paginator.ListOrdersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOutpostsPaginator(self: *Self, params: list_outposts.ListOutpostsInput) paginator.ListOutpostsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSitesPaginator(self: *Self, params: list_sites.ListSitesInput) paginator.ListSitesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
