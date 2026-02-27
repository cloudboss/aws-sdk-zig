/// Defines which resources trigger an evaluation for an Config
/// rule. The scope can include one or more resource types, a
/// combination of a tag key and value, or a combination of one resource
/// type and one resource ID. Specify a scope to constrain which
/// resources trigger an evaluation for a rule. Otherwise, evaluations
/// for the rule are triggered when any resource in your recording group
/// changes in configuration.
pub const Scope = struct {
    /// The ID of the only Amazon Web Services resource that you want to trigger an
    /// evaluation for the rule. If you specify a resource ID, you must
    /// specify one resource type for
    /// `ComplianceResourceTypes`.
    compliance_resource_id: ?[]const u8,

    /// The resource types of only those Amazon Web Services resources that you want
    /// to
    /// trigger an evaluation for the rule. You can only specify one type if
    /// you also specify a resource ID for
    /// `ComplianceResourceId`.
    compliance_resource_types: ?[]const []const u8,

    /// The tag key that is applied to only those Amazon Web Services resources that
    /// you want to trigger an evaluation for the rule.
    tag_key: ?[]const u8,

    /// The tag value applied to only those Amazon Web Services resources that you
    /// want
    /// to trigger an evaluation for the rule. If you specify a value for
    /// `TagValue`, you must also specify a value for
    /// `TagKey`.
    tag_value: ?[]const u8,

    pub const json_field_names = .{
        .compliance_resource_id = "ComplianceResourceId",
        .compliance_resource_types = "ComplianceResourceTypes",
        .tag_key = "TagKey",
        .tag_value = "TagValue",
    };
};
