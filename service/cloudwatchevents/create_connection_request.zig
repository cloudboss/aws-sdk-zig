const ConnectionAuthorizationType = @import("connection_authorization_type.zig").ConnectionAuthorizationType;
const CreateConnectionAuthRequestParameters = @import("create_connection_auth_request_parameters.zig").CreateConnectionAuthRequestParameters;

pub const CreateConnectionRequest = struct {
    /// The type of authorization to use for the connection.
    authorization_type: ConnectionAuthorizationType,

    /// A `CreateConnectionAuthRequestParameters` object that contains the
    /// authorization parameters to use to authorize with the endpoint.
    auth_parameters: CreateConnectionAuthRequestParameters,

    /// A description for the connection to create.
    description: ?[]const u8,

    /// The name for the connection to create.
    name: []const u8,

    pub const json_field_names = .{
        .authorization_type = "AuthorizationType",
        .auth_parameters = "AuthParameters",
        .description = "Description",
        .name = "Name",
    };
};
