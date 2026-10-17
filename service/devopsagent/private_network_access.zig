/// Private network access to the resource inside a VPC, using a private
/// connection.
pub const PrivateNetworkAccess = struct {
    /// Name of the private connection that supplies the VPC configuration for this
    /// release management environment.
    private_connection_name: []const u8,

    /// Role ARN that AWS DevOps Agent assumes at runtime to connect to your VPC.
    runtime_role_arn: []const u8,

    pub const json_field_names = .{
        .private_connection_name = "privateConnectionName",
        .runtime_role_arn = "runtimeRoleArn",
    };
};
