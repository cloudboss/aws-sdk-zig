const AttachPoint = @import("attach_point.zig").AttachPoint;
const Provider = @import("provider.zig").Provider;
const ConnectionState = @import("connection_state.zig").ConnectionState;

/// Summarized view of a Connection object.
pub const ConnectionSummary = struct {
    /// The ARN of the Connection
    arn: []const u8,

    /// The Attach Point to which the connection should be associated.
    attach_point: AttachPoint,

    /// The bandwidth of the Connection
    bandwidth: []const u8,

    /// The billing tier this connection is currently assigned.
    billing_tier: ?i32 = null,

    /// A descriptive name of the Connection
    description: []const u8,

    /// The Environment that this Connection is created on.
    environment_id: []const u8,

    /// The identifier of the requested Connection
    id: []const u8,

    /// The provider specific location at the remote end of this Connection
    location: []const u8,

    /// The provider on the remote end of this Connection
    provider: Provider,

    /// An identifier used by both AWS and the remote partner to identify the
    /// specific connection.
    shared_id: []const u8,

    /// * `requested`: The initial state of a connection. The state will remain here
    ///   until the Connection is accepted on the Partner portal.
    /// * `pending`: The connection has been accepted and is being provisioned
    ///   between AWS and the Partner.
    /// * `available`: The connection has been fully provisioned between AWS and the
    ///   Partner.
    /// * `deleting`: The connection is being deleted.
    /// * `deleted`: The connection has been deleted.
    /// * `failed`: The connection has failed to be created.
    /// * `updating`: The connection is being updated.
    state: ConnectionState,

    /// The product variant supplied by this resource.
    type: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .attach_point = "attachPoint",
        .bandwidth = "bandwidth",
        .billing_tier = "billingTier",
        .description = "description",
        .environment_id = "environmentId",
        .id = "id",
        .location = "location",
        .provider = "provider",
        .shared_id = "sharedId",
        .state = "state",
        .type = "type",
    };
};
