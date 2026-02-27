const AudienceDestination = @import("audience_destination.zig").AudienceDestination;

/// Configuration information necessary for the configure audience model output.
pub const ConfiguredAudienceModelOutputConfig = struct {
    destination: AudienceDestination,

    /// The ARN of the IAM role that can write the Amazon S3 bucket.
    role_arn: []const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .role_arn = "roleArn",
    };
};
