const ProtectionGroupAggregation = @import("protection_group_aggregation.zig").ProtectionGroupAggregation;
const ProtectionGroupPattern = @import("protection_group_pattern.zig").ProtectionGroupPattern;
const ProtectedResourceType = @import("protected_resource_type.zig").ProtectedResourceType;

/// A grouping of protected resources that you and Shield Advanced can monitor
/// as a collective. This resource grouping improves the accuracy of detection
/// and reduces false positives.
pub const ProtectionGroup = struct {
    /// Defines how Shield combines resource data for the group in order to detect,
    /// mitigate, and report events.
    ///
    /// * Sum - Use the total traffic across the group. This is a good choice for
    ///   most cases. Examples include Elastic IP addresses for EC2 instances that
    ///   scale manually or automatically.
    ///
    /// * Mean - Use the average of the traffic across the group. This is a good
    ///   choice for resources that share traffic uniformly. Examples include
    ///   accelerators and load balancers.
    ///
    /// * Max - Use the highest traffic from each resource. This is useful for
    ///   resources that don't share traffic and for resources that share that
    ///   traffic in a non-uniform way. Examples include Amazon CloudFront
    ///   distributions and origin resources for CloudFront distributions.
    aggregation: ProtectionGroupAggregation,

    /// The ARNs (Amazon Resource Names) of the resources to include in the
    /// protection group. You must set this when you set `Pattern` to `ARBITRARY`
    /// and you must not set it for any other `Pattern` setting.
    members: []const []const u8,

    /// The criteria to use to choose the protected resources for inclusion in the
    /// group. You can include all resources that have protections, provide a list
    /// of resource ARNs (Amazon Resource Names), or include all resources of a
    /// specified resource type.
    pattern: ProtectionGroupPattern,

    /// The ARN (Amazon Resource Name) of the protection group.
    protection_group_arn: ?[]const u8 = null,

    /// The name of the protection group. You use this to identify the protection
    /// group in lists and to manage the protection group, for example to update,
    /// delete, or describe it.
    protection_group_id: []const u8,

    /// The resource type to include in the protection group. All protected
    /// resources of this type are included in the protection group.
    /// You must set this when you set `Pattern` to `BY_RESOURCE_TYPE` and you must
    /// not set it for any other `Pattern` setting.
    resource_type: ?ProtectedResourceType = null,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .members = "Members",
        .pattern = "Pattern",
        .protection_group_arn = "ProtectionGroupArn",
        .protection_group_id = "ProtectionGroupId",
        .resource_type = "ResourceType",
    };
};
