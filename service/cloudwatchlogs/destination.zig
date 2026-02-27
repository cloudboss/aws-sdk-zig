/// Represents a cross-account destination that receives subscription log
/// events.
pub const Destination = struct {
    /// An IAM policy document that governs which Amazon Web Services accounts can
    /// create
    /// subscription filters against this destination.
    access_policy: ?[]const u8,

    /// The ARN of this destination.
    arn: ?[]const u8,

    /// The creation time of the destination, expressed as the number of
    /// milliseconds after Jan
    /// 1, 1970 00:00:00 UTC.
    creation_time: ?i64,

    /// The name of the destination.
    destination_name: ?[]const u8,

    /// A role for impersonation, used when delivering log events to the target.
    role_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the physical target where the log events
    /// are
    /// delivered (for example, a Kinesis stream).
    target_arn: ?[]const u8,

    pub const json_field_names = .{
        .access_policy = "accessPolicy",
        .arn = "arn",
        .creation_time = "creationTime",
        .destination_name = "destinationName",
        .role_arn = "roleArn",
        .target_arn = "targetArn",
    };
};
