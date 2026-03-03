const Destination = @import("destination.zig").Destination;

/// Configuration information about how the exported model artifacts are stored.
pub const MLOutputConfiguration = struct {
    /// The Amazon S3 location where exported model artifacts are stored.
    destination: ?Destination = null,

    /// The Amazon Resource Name (ARN) of the service access role that is used to
    /// store the model artifacts.
    role_arn: []const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .role_arn = "roleArn",
    };
};
