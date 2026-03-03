const CloudTrailProperties = @import("cloud_trail_properties.zig").CloudTrailProperties;

/// Contains the generated policy details.
pub const GeneratedPolicyProperties = struct {
    /// Lists details about the `Trail` used to generated policy.
    cloud_trail_properties: ?CloudTrailProperties = null,

    /// This value is set to `true` if the generated policy contains all possible
    /// actions for a service that IAM Access Analyzer identified from the
    /// CloudTrail trail that you specified, and `false` otherwise.
    is_complete: ?bool = null,

    /// The ARN of the IAM entity (user or role) for which you are generating a
    /// policy.
    principal_arn: []const u8,

    pub const json_field_names = .{
        .cloud_trail_properties = "cloudTrailProperties",
        .is_complete = "isComplete",
        .principal_arn = "principalArn",
    };
};
