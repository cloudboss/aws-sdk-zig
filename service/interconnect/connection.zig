const aws = @import("aws");

const AttachPoint = @import("attach_point.zig").AttachPoint;
const Provider = @import("provider.zig").Provider;
const ConnectionState = @import("connection_state.zig").ConnectionState;

/// The object describing the provided connectivity from the AWS region to the
/// partner location.
pub const Connection = struct {
    /// The Activation Key associated to this connection.
    activation_key: []const u8,

    /// An ARN of a Connection object.
    arn: []const u8,

    /// The Attach Point to which the connection should be associated."
    attach_point: AttachPoint,

    /// The specific selected bandwidth of this connection.
    bandwidth: []const u8,

    /// The billing tier this connection is currently assigned.
    billing_tier: ?i32 = null,

    /// A descriptive name for the connection.
    description: []const u8,

    /// The specific Environment this connection is placed upon.
    environment_id: []const u8,

    /// The short identifier of the connection object.
    id: []const u8,

    /// The provider specific location on the remote side of this Connection
    location: []const u8,

    /// The account that owns this Connection
    owner_account: []const u8,

    /// The provider on the remote side of this Connection.
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

    /// The tags on the Connection
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The specific product type of this Connection.
    type: []const u8,

    pub const json_field_names = .{
        .activation_key = "activationKey",
        .arn = "arn",
        .attach_point = "attachPoint",
        .bandwidth = "bandwidth",
        .billing_tier = "billingTier",
        .description = "description",
        .environment_id = "environmentId",
        .id = "id",
        .location = "location",
        .owner_account = "ownerAccount",
        .provider = "provider",
        .shared_id = "sharedId",
        .state = "state",
        .tags = "tags",
        .type = "type",
    };
};
