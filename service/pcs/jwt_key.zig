/// The JWT key stored in Amazon Web Services Secrets Manager for Slurm REST API
/// authentication.
pub const JwtKey = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret containing the JWT key.
    secret_arn: []const u8,

    /// The version of the Amazon Web Services Secrets Manager secret containing the
    /// JWT key.
    secret_version: []const u8,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
        .secret_version = "secretVersion",
    };
};
