const aws = @import("aws");
const std = @import("std");

const get_routing_control_state = @import("get_routing_control_state.zig");
const list_routing_controls = @import("list_routing_controls.zig");
const update_routing_control_state = @import("update_routing_control_state.zig");
const update_routing_control_states = @import("update_routing_control_states.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route53 Recovery Cluster";

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

    /// Get the state for a routing control. A routing control is a simple on/off
    /// switch that you
    /// can use to route traffic to cells. When a routing control state is set to
    /// ON, traffic flows to a cell. When
    /// the state is set to OFF, traffic does not flow.
    ///
    /// Before you can create a routing control, you must first create a cluster,
    /// and then host the control
    /// in a control panel on the cluster. For more information, see [
    /// Create routing control
    /// structures](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.create.html) in the Amazon Route 53 Application Recovery Controller Developer Guide.
    /// You access one of the endpoints for the cluster to get or update the routing
    /// control state to
    /// redirect traffic for your application.
    ///
    /// *You must specify Regional endpoints when you work with API cluster
    /// operations
    /// to get or update routing control states in Route 53 ARC.*
    ///
    /// To see a code example for getting a routing control state, including
    /// accessing Regional cluster endpoints
    /// in sequence, see [API
    /// examples](https://docs.aws.amazon.com/r53recovery/latest/dg/service_code_examples_actions.html)
    /// in the Amazon Route 53 Application Recovery Controller Developer Guide.
    ///
    /// Learn more about working with routing controls in the following topics in
    /// the
    /// Amazon Route 53 Application Recovery Controller Developer Guide:
    ///
    /// * [
    /// Viewing and updating routing control
    /// states](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.update.html)
    ///
    /// * [Working with
    /// routing controls in Route 53
    /// ARC](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.html)
    pub fn getRoutingControlState(self: *Self, allocator: std.mem.Allocator, input: get_routing_control_state.GetRoutingControlStateInput, options: get_routing_control_state.Options) !get_routing_control_state.GetRoutingControlStateOutput {
        return get_routing_control_state.execute(self, allocator, input, options);
    }

    /// List routing control names and Amazon Resource Names (ARNs), as well as the
    /// routing control
    /// state for each routing control, along with the control panel name and
    /// control panel ARN for the routing controls.
    /// If you specify a control panel ARN, this call lists the routing controls in
    /// the control panel. Otherwise, it lists
    /// all the routing controls in the cluster.
    ///
    /// A routing control is a simple on/off switch in Route 53 ARC that you
    /// can use to route traffic to cells. When a routing control state is set to
    /// ON, traffic flows to a cell. When
    /// the state is set to OFF, traffic does not flow.
    ///
    /// Before you can create a routing control, you must first create a cluster,
    /// and then host the control
    /// in a control panel on the cluster. For more information, see [
    /// Create routing control
    /// structures](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.create.html) in the Amazon Route 53 Application Recovery Controller Developer Guide.
    /// You access one of the endpoints for the cluster to get or update the routing
    /// control state to
    /// redirect traffic for your application.
    ///
    /// *You must specify Regional endpoints when you work with API cluster
    /// operations
    /// to use this API operation to list routing controls in Route 53 ARC.*
    ///
    /// Learn more about working with routing controls in the following topics in
    /// the
    /// Amazon Route 53 Application Recovery Controller Developer Guide:
    ///
    /// * [
    /// Viewing and updating routing control
    /// states](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.update.html)
    ///
    /// * [Working with
    /// routing controls in Route 53
    /// ARC](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.html)
    pub fn listRoutingControls(self: *Self, allocator: std.mem.Allocator, input: list_routing_controls.ListRoutingControlsInput, options: list_routing_controls.Options) !list_routing_controls.ListRoutingControlsOutput {
        return list_routing_controls.execute(self, allocator, input, options);
    }

    /// Set the state of the routing control to reroute traffic. You can set the
    /// value to ON or
    /// OFF. When the state is ON, traffic flows to a cell. When the state is OFF,
    /// traffic does not
    /// flow.
    ///
    /// With Route 53 ARC, you can add safety rules for routing controls, which are
    /// safeguards for routing
    /// control state updates that help prevent unexpected outcomes, like fail open
    /// traffic routing. However,
    /// there are scenarios when you might want to bypass the routing control
    /// safeguards that are enforced with
    /// safety rules that you've configured. For example, you might want to fail
    /// over quickly for disaster recovery,
    /// and one or more safety rules might be unexpectedly preventing you from
    /// updating a routing control state to
    /// reroute traffic. In a "break glass" scenario like this, you can override one
    /// or more safety rules to change
    /// a routing control state and fail over your application.
    ///
    /// The `SafetyRulesToOverride` property enables you override one or more safety
    /// rules and
    /// update routing control states. For more information, see
    /// [
    /// Override safety rules to reroute
    /// traffic](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.override-safety-rule.html) in the Amazon Route 53 Application Recovery Controller Developer Guide.
    ///
    /// *You must specify Regional endpoints when you work with API cluster
    /// operations
    /// to get or update routing control states in Route 53 ARC.*
    ///
    /// To see a code example for getting a routing control state, including
    /// accessing Regional cluster endpoints
    /// in sequence, see [API
    /// examples](https://docs.aws.amazon.com/r53recovery/latest/dg/service_code_examples_actions.html)
    /// in the Amazon Route 53 Application Recovery Controller Developer Guide.
    ///
    /// * [
    /// Viewing and updating routing control
    /// states](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.update.html)
    ///
    /// * [Working with routing controls
    ///   overall](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.html)
    pub fn updateRoutingControlState(self: *Self, allocator: std.mem.Allocator, input: update_routing_control_state.UpdateRoutingControlStateInput, options: update_routing_control_state.Options) !update_routing_control_state.UpdateRoutingControlStateOutput {
        return update_routing_control_state.execute(self, allocator, input, options);
    }

    /// Set multiple routing control states. You can set the value for each state to
    /// be ON or OFF.
    /// When the state is ON, traffic flows to a cell. When it's OFF, traffic does
    /// not
    /// flow.
    ///
    /// With Route 53 ARC, you can add safety rules for routing controls, which are
    /// safeguards for routing
    /// control state updates that help prevent unexpected outcomes, like fail open
    /// traffic routing. However,
    /// there are scenarios when you might want to bypass the routing control
    /// safeguards that are enforced with
    /// safety rules that you've configured. For example, you might want to fail
    /// over quickly for disaster recovery,
    /// and one or more safety rules might be unexpectedly preventing you from
    /// updating a routing control state to
    /// reroute traffic. In a "break glass" scenario like this, you can override one
    /// or more safety rules to change
    /// a routing control state and fail over your application.
    ///
    /// The `SafetyRulesToOverride` property enables you override one or more safety
    /// rules and
    /// update routing control states. For more information, see
    /// [
    /// Override safety rules to reroute
    /// traffic](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.override-safety-rule.html) in the Amazon Route 53 Application Recovery Controller Developer Guide.
    ///
    /// *You must specify Regional endpoints when you work with API cluster
    /// operations
    /// to get or update routing control states in Route 53 ARC.*
    ///
    /// To see a code example for getting a routing control state, including
    /// accessing Regional cluster endpoints
    /// in sequence, see [API
    /// examples](https://docs.aws.amazon.com/r53recovery/latest/dg/service_code_examples_actions.html)
    /// in the Amazon Route 53 Application Recovery Controller Developer Guide.
    ///
    /// * [
    /// Viewing and updating routing control
    /// states](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.update.html)
    ///
    /// * [Working with routing controls
    ///   overall](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.html)
    pub fn updateRoutingControlStates(self: *Self, allocator: std.mem.Allocator, input: update_routing_control_states.UpdateRoutingControlStatesInput, options: update_routing_control_states.Options) !update_routing_control_states.UpdateRoutingControlStatesOutput {
        return update_routing_control_states.execute(self, allocator, input, options);
    }

    pub fn listRoutingControlsPaginator(self: *Self, params: list_routing_controls.ListRoutingControlsInput) paginator.ListRoutingControlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
