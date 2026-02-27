const AwsLocation = @import("aws_location.zig").AwsLocation;
const GlueConnection = @import("glue_connection.zig").GlueConnection;
const Protocol = @import("protocol.zig").Protocol;

/// The physical endpoints of a connection.
pub const PhysicalEndpoint = struct {
    /// The location of a connection.
    aws_location: ?AwsLocation,

    /// Specified whether trusted identity propagation for the connection is
    /// enabled.
    enable_trusted_identity_propagation: ?bool,

    /// The Amazon Web Services Glue connection.
    glue_connection: ?GlueConnection,

    /// The Amazon Web Services Glue connection name.
    glue_connection_name: ?[]const u8,

    /// The host in the physical endpoints of a connection.
    host: ?[]const u8,

    /// The port in the physical endpoints of a connection.
    port: ?i32,

    /// The protocol in the physical endpoints of a connection.
    protocol: ?Protocol,

    /// The stage in the physical endpoints of a connection.
    stage: ?[]const u8,

    pub const json_field_names = .{
        .aws_location = "awsLocation",
        .enable_trusted_identity_propagation = "enableTrustedIdentityPropagation",
        .glue_connection = "glueConnection",
        .glue_connection_name = "glueConnectionName",
        .host = "host",
        .port = "port",
        .protocol = "protocol",
        .stage = "stage",
    };
};
