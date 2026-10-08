const aws = @import("aws");
const std = @import("std");

const create_network_connector = @import("create_network_connector.zig");
const delete_network_connector = @import("delete_network_connector.zig");
const get_network_connector = @import("get_network_connector.zig");
const list_network_connectors = @import("list_network_connectors.zig");
const update_network_connector = @import("update_network_connector.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Lambda Core";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Creates a network connector that enables Lambda compute resources to route
    /// outbound traffic through your Amazon VPC. The network connector provisions
    /// elastic network interfaces (ENIs) in the subnets you specify, providing a
    /// managed network path to private resources such as databases, caches, and
    /// internal APIs.
    ///
    /// This operation is asynchronous. The network connector starts in `PENDING`
    /// state while ENIs are provisioned in your VPC (provisioning typically takes
    /// up to 10 minutes). Use `GetNetworkConnector` to poll the connector state
    /// until it reaches `ACTIVE`. Once active, you can attach the connector to
    /// Lambda MicroVMs at run time using the `egressNetworkConnectors` parameter on
    /// `RunMicroVm`.
    ///
    /// This operation is idempotent when you provide a `ClientToken` — if you retry
    /// a request that completed successfully using the same client token, the
    /// operation returns the existing connector without creating a duplicate.
    pub fn createNetworkConnector(self: *Self, allocator: std.mem.Allocator, input: create_network_connector.CreateNetworkConnectorInput, options: CallOptions) !create_network_connector.CreateNetworkConnectorOutput {
        return create_network_connector.execute(self, allocator, input, options);
    }

    /// Initiates deletion of a network connector. The connector transitions to
    /// `DELETING` state while elastic network interfaces are cleaned up
    /// asynchronously. After deletion completes, subsequent calls to
    /// `GetNetworkConnector` return `ResourceNotFoundException`.
    ///
    /// This operation is idempotent — calling delete on a connector that is already
    /// deleting or has been deleted succeeds without error. You can delete
    /// connectors in `ACTIVE` or `FAILED` states. Before deleting a connector,
    /// ensure that no Lambda MicroVMs are using it, as they will lose VPC egress
    /// connectivity immediately.
    pub fn deleteNetworkConnector(self: *Self, allocator: std.mem.Allocator, input: delete_network_connector.DeleteNetworkConnectorInput, options: CallOptions) !delete_network_connector.DeleteNetworkConnectorOutput {
        return delete_network_connector.execute(self, allocator, input, options);
    }

    /// Retrieves the current configuration, state, and metadata of a network
    /// connector. The `Identifier` parameter accepts the connector ID, name, or
    /// full ARN. Use this operation to poll connector state after creation or
    /// update, or to inspect the current VPC configuration and any failure reasons.
    ///
    /// The response includes the full connector configuration, current state, and —
    /// if the connector has been updated — the `LastUpdateStatus` and
    /// `LastUpdateStatusReasonCode` fields that indicate whether the most recent
    /// update succeeded or failed.
    pub fn getNetworkConnector(self: *Self, allocator: std.mem.Allocator, input: get_network_connector.GetNetworkConnectorInput, options: CallOptions) !get_network_connector.GetNetworkConnectorOutput {
        return get_network_connector.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of network connectors in your account for the
    /// current Region. You can optionally filter results by connector state. Use
    /// the `Marker` parameter from a previous response to retrieve the next page of
    /// results.
    ///
    /// Each item in the response includes the connector ARN, name, ID, type,
    /// current state, and last modified timestamp. To retrieve full configuration
    /// details for a specific connector, use `GetNetworkConnector`.
    pub fn listNetworkConnectors(self: *Self, allocator: std.mem.Allocator, input: list_network_connectors.ListNetworkConnectorsInput, options: CallOptions) !list_network_connectors.ListNetworkConnectorsOutput {
        return list_network_connectors.execute(self, allocator, input, options);
    }

    /// Updates the VPC configuration or operator role of an existing network
    /// connector. You can modify the subnet IDs, security group IDs, network
    /// protocol, or operator role. The connector must be in `ACTIVE` state to
    /// accept updates.
    ///
    /// This operation is asynchronous. The connector remains in `ACTIVE` state
    /// during the update — existing workloads that reference this connector are not
    /// disrupted. Use `GetNetworkConnector` to monitor the `LastUpdateStatus`
    /// field, which transitions through `InProgress` to `Successful` or `Failed`.
    /// If the update fails, the `LastUpdateStatusReasonCode` field provides a
    /// specific error code for troubleshooting. This operation is idempotent when
    /// you provide a `ClientToken`.
    pub fn updateNetworkConnector(self: *Self, allocator: std.mem.Allocator, input: update_network_connector.UpdateNetworkConnectorInput, options: CallOptions) !update_network_connector.UpdateNetworkConnectorOutput {
        return update_network_connector.execute(self, allocator, input, options);
    }

    pub fn listNetworkConnectorsPaginator(self: *Self, params: list_network_connectors.ListNetworkConnectorsInput) paginator.ListNetworkConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
