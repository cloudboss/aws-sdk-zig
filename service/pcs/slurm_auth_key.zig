/// The shared Slurm key for authentication, also known as the **cluster
/// secret**.
pub const SlurmAuthKey = struct {
    /// The Amazon Resource Name (ARN) of the shared Slurm key.
    secret_arn: []const u8,

    /// The version of the shared Slurm key.
    secret_version: []const u8,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
        .secret_version = "secretVersion",
    };
};
