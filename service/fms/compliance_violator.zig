const aws = @import("aws");

const ViolationReason = @import("violation_reason.zig").ViolationReason;

/// Details of the resource that is not protected by the policy.
pub const ComplianceViolator = struct {
    /// Metadata about the resource that doesn't comply with the policy scope.
    metadata: ?[]const aws.map.StringMapEntry,

    /// The resource ID.
    resource_id: ?[]const u8,

    /// The resource type. This is in the format shown in the [Amazon Web Services
    /// Resource Types
    /// Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html). For example:
    /// `AWS::ElasticLoadBalancingV2::LoadBalancer`,
    /// `AWS::CloudFront::Distribution`, or
    /// `AWS::NetworkFirewall::FirewallPolicy`.
    resource_type: ?[]const u8,

    /// The reason that the resource is not protected by the policy.
    violation_reason: ?ViolationReason,

    pub const json_field_names = .{
        .metadata = "Metadata",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .violation_reason = "ViolationReason",
    };
};
