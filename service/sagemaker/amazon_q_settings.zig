const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// A collection of settings that configure the Amazon Q experience within the
/// domain.
pub const AmazonQSettings = struct {
    /// The ARN of the Amazon Q profile used within the domain.
    q_profile_arn: ?[]const u8 = null,

    /// Whether Amazon Q has been enabled within the domain.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .q_profile_arn = "QProfileArn",
        .status = "Status",
    };
};
