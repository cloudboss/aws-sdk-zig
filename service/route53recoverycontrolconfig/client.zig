const aws = @import("aws");
const std = @import("std");

const create_cluster = @import("create_cluster.zig");
const create_control_panel = @import("create_control_panel.zig");
const create_routing_control = @import("create_routing_control.zig");
const create_safety_rule = @import("create_safety_rule.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_control_panel = @import("delete_control_panel.zig");
const delete_routing_control = @import("delete_routing_control.zig");
const delete_safety_rule = @import("delete_safety_rule.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_control_panel = @import("describe_control_panel.zig");
const describe_routing_control = @import("describe_routing_control.zig");
const describe_safety_rule = @import("describe_safety_rule.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_associated_route_53_health_checks = @import("list_associated_route_53_health_checks.zig");
const list_clusters = @import("list_clusters.zig");
const list_control_panels = @import("list_control_panels.zig");
const list_routing_controls = @import("list_routing_controls.zig");
const list_safety_rules = @import("list_safety_rules.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cluster = @import("update_cluster.zig");
const update_control_panel = @import("update_control_panel.zig");
const update_routing_control = @import("update_routing_control.zig");
const update_safety_rule = @import("update_safety_rule.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route53 Recovery Control Config";

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

    /// Create a new cluster. A cluster is a set of redundant Regional endpoints
    /// against which you can run API calls to update or get the state of one or
    /// more routing controls. Each cluster has a name, status, Amazon Resource Name
    /// (ARN), and an array of the five cluster endpoints (one for each supported
    /// Amazon Web Services Region) that you can use with API calls to the cluster
    /// data plane.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new control panel. A control panel represents a group of routing
    /// controls that can be changed together in a single transaction. You can use a
    /// control panel to centrally view the operational status of applications
    /// across your organization, and trigger multi-app failovers in a single
    /// transaction, for example, to fail over an Availability Zone or Amazon Web
    /// Services Region.
    pub fn createControlPanel(self: *Self, allocator: std.mem.Allocator, input: create_control_panel.CreateControlPanelInput, options: create_control_panel.Options) !create_control_panel.CreateControlPanelOutput {
        return create_control_panel.execute(self, allocator, input, options);
    }

    /// Creates a new routing control.
    ///
    /// A routing control has one of two states: ON and OFF. You can map the routing
    /// control state to the state of an Amazon Route 53 health check, which can be
    /// used to control traffic routing.
    ///
    /// To get or update the routing control state, see the Recovery Cluster (data
    /// plane) API actions for Amazon Route 53 Application Recovery Controller.
    pub fn createRoutingControl(self: *Self, allocator: std.mem.Allocator, input: create_routing_control.CreateRoutingControlInput, options: create_routing_control.Options) !create_routing_control.CreateRoutingControlOutput {
        return create_routing_control.execute(self, allocator, input, options);
    }

    /// Creates a safety rule in a control panel. Safety rules let you add
    /// safeguards around changing routing control states, and for enabling and
    /// disabling routing controls, to help prevent unexpected outcomes.
    ///
    /// There are two types of safety rules: assertion rules and gating rules.
    ///
    /// Assertion rule: An assertion rule enforces that, when you change a routing
    /// control state, that a certain criteria is met. For example, the criteria
    /// might be that at least one routing control state is On after the transaction
    /// so that traffic continues to flow to at least one cell for the application.
    /// This ensures that you avoid a fail-open scenario.
    ///
    /// Gating rule: A gating rule lets you configure a gating routing control as an
    /// overall "on/off" switch for a group of routing controls. Or, you can
    /// configure more complex gating scenarios, for example by configuring multiple
    /// gating routing controls.
    ///
    /// For more information, see [Safety
    /// rules](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.safety-rules.html) in the Amazon Route 53 Application Recovery Controller Developer Guide.
    pub fn createSafetyRule(self: *Self, allocator: std.mem.Allocator, input: create_safety_rule.CreateSafetyRuleInput, options: create_safety_rule.Options) !create_safety_rule.CreateSafetyRuleOutput {
        return create_safety_rule.execute(self, allocator, input, options);
    }

    /// Delete a cluster.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a control panel.
    pub fn deleteControlPanel(self: *Self, allocator: std.mem.Allocator, input: delete_control_panel.DeleteControlPanelInput, options: delete_control_panel.Options) !delete_control_panel.DeleteControlPanelOutput {
        return delete_control_panel.execute(self, allocator, input, options);
    }

    /// Deletes a routing control.
    pub fn deleteRoutingControl(self: *Self, allocator: std.mem.Allocator, input: delete_routing_control.DeleteRoutingControlInput, options: delete_routing_control.Options) !delete_routing_control.DeleteRoutingControlOutput {
        return delete_routing_control.execute(self, allocator, input, options);
    }

    /// Deletes a safety rule./>
    pub fn deleteSafetyRule(self: *Self, allocator: std.mem.Allocator, input: delete_safety_rule.DeleteSafetyRuleInput, options: delete_safety_rule.Options) !delete_safety_rule.DeleteSafetyRuleOutput {
        return delete_safety_rule.execute(self, allocator, input, options);
    }

    /// Display the details about a cluster. The response includes the cluster name,
    /// endpoints, status, and Amazon Resource Name (ARN).
    pub fn describeCluster(self: *Self, allocator: std.mem.Allocator, input: describe_cluster.DescribeClusterInput, options: describe_cluster.Options) !describe_cluster.DescribeClusterOutput {
        return describe_cluster.execute(self, allocator, input, options);
    }

    /// Displays details about a control panel.
    pub fn describeControlPanel(self: *Self, allocator: std.mem.Allocator, input: describe_control_panel.DescribeControlPanelInput, options: describe_control_panel.Options) !describe_control_panel.DescribeControlPanelOutput {
        return describe_control_panel.execute(self, allocator, input, options);
    }

    /// Displays details about a routing control. A routing control has one of two
    /// states: ON and OFF. You can map the routing control state to the state of an
    /// Amazon Route 53 health check, which can be used to control routing.
    ///
    /// To get or update the routing control state, see the Recovery Cluster (data
    /// plane) API actions for Amazon Route 53 Application Recovery Controller.
    pub fn describeRoutingControl(self: *Self, allocator: std.mem.Allocator, input: describe_routing_control.DescribeRoutingControlInput, options: describe_routing_control.Options) !describe_routing_control.DescribeRoutingControlOutput {
        return describe_routing_control.execute(self, allocator, input, options);
    }

    /// Returns information about a safety rule.
    pub fn describeSafetyRule(self: *Self, allocator: std.mem.Allocator, input: describe_safety_rule.DescribeSafetyRuleInput, options: describe_safety_rule.Options) !describe_safety_rule.DescribeSafetyRuleOutput {
        return describe_safety_rule.execute(self, allocator, input, options);
    }

    /// Get information about the resource policy for a cluster.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns an array of all Amazon Route 53 health checks associated with a
    /// specific routing control.
    pub fn listAssociatedRoute53HealthChecks(self: *Self, allocator: std.mem.Allocator, input: list_associated_route_53_health_checks.ListAssociatedRoute53HealthChecksInput, options: list_associated_route_53_health_checks.Options) !list_associated_route_53_health_checks.ListAssociatedRoute53HealthChecksOutput {
        return list_associated_route_53_health_checks.execute(self, allocator, input, options);
    }

    /// Returns an array of all the clusters in an account.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Returns an array of control panels in an account or in a cluster.
    pub fn listControlPanels(self: *Self, allocator: std.mem.Allocator, input: list_control_panels.ListControlPanelsInput, options: list_control_panels.Options) !list_control_panels.ListControlPanelsOutput {
        return list_control_panels.execute(self, allocator, input, options);
    }

    /// Returns an array of routing controls for a control panel. A routing control
    /// is an Amazon Route 53 Application Recovery Controller construct that has one
    /// of two states: ON and OFF. You can map the routing control state to the
    /// state of an Amazon Route 53 health check, which can be used to control
    /// routing.
    pub fn listRoutingControls(self: *Self, allocator: std.mem.Allocator, input: list_routing_controls.ListRoutingControlsInput, options: list_routing_controls.Options) !list_routing_controls.ListRoutingControlsOutput {
        return list_routing_controls.execute(self, allocator, input, options);
    }

    /// List the safety rules (the assertion rules and gating rules) that you've
    /// defined for the routing controls in a control panel.
    pub fn listSafetyRules(self: *Self, allocator: std.mem.Allocator, input: list_safety_rules.ListSafetyRulesInput, options: list_safety_rules.Options) !list_safety_rules.ListSafetyRulesOutput {
        return list_safety_rules.execute(self, allocator, input, options);
    }

    /// Lists the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing cluster. You can only update the network type of a
    /// cluster.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// Updates a control panel. The only update you can make to a control panel is
    /// to change the name of the control panel.
    pub fn updateControlPanel(self: *Self, allocator: std.mem.Allocator, input: update_control_panel.UpdateControlPanelInput, options: update_control_panel.Options) !update_control_panel.UpdateControlPanelOutput {
        return update_control_panel.execute(self, allocator, input, options);
    }

    /// Updates a routing control. You can only update the name of the routing
    /// control. To get or update the routing control state, see the Recovery
    /// Cluster (data plane) API actions for Amazon Route 53 Application Recovery
    /// Controller.
    pub fn updateRoutingControl(self: *Self, allocator: std.mem.Allocator, input: update_routing_control.UpdateRoutingControlInput, options: update_routing_control.Options) !update_routing_control.UpdateRoutingControlOutput {
        return update_routing_control.execute(self, allocator, input, options);
    }

    /// Update a safety rule (an assertion rule or gating rule). You can only update
    /// the name and the waiting period for a safety rule. To make other updates,
    /// delete the safety rule and create a new one.
    pub fn updateSafetyRule(self: *Self, allocator: std.mem.Allocator, input: update_safety_rule.UpdateSafetyRuleInput, options: update_safety_rule.Options) !update_safety_rule.UpdateSafetyRuleOutput {
        return update_safety_rule.execute(self, allocator, input, options);
    }

    pub fn listAssociatedRoute53HealthChecksPaginator(self: *Self, params: list_associated_route_53_health_checks.ListAssociatedRoute53HealthChecksInput) paginator.ListAssociatedRoute53HealthChecksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listControlPanelsPaginator(self: *Self, params: list_control_panels.ListControlPanelsInput) paginator.ListControlPanelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoutingControlsPaginator(self: *Self, params: list_routing_controls.ListRoutingControlsInput) paginator.ListRoutingControlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSafetyRulesPaginator(self: *Self, params: list_safety_rules.ListSafetyRulesInput) paginator.ListSafetyRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilClusterCreated(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterDeleted(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilControlPanelCreated(self: *Self, params: describe_control_panel.DescribeControlPanelInput) aws.waiter.WaiterError!void {
        var w = waiters.ControlPanelCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilControlPanelDeleted(self: *Self, params: describe_control_panel.DescribeControlPanelInput) aws.waiter.WaiterError!void {
        var w = waiters.ControlPanelDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRoutingControlCreated(self: *Self, params: describe_routing_control.DescribeRoutingControlInput) aws.waiter.WaiterError!void {
        var w = waiters.RoutingControlCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRoutingControlDeleted(self: *Self, params: describe_routing_control.DescribeRoutingControlInput) aws.waiter.WaiterError!void {
        var w = waiters.RoutingControlDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
