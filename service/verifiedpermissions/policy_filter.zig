const PolicyType = @import("policy_type.zig").PolicyType;
const EntityReference = @import("entity_reference.zig").EntityReference;

/// Contains information about a filter to refine policies returned in a query.
///
/// This data type is used as a response parameter for the
/// [ListPolicies](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicies.html) operation.
pub const PolicyFilter = struct {
    /// Filters the output to only template-linked policies that were instantiated
    /// from the specified policy template.
    policy_template_id: ?[]const u8,

    /// Filters the output to only policies of the specified type.
    policy_type: ?PolicyType,

    /// Filters the output to only policies that reference the specified principal.
    principal: ?EntityReference,

    /// Filters the output to only policies that reference the specified resource.
    resource: ?EntityReference,

    pub const json_field_names = .{
        .policy_template_id = "policyTemplateId",
        .policy_type = "policyType",
        .principal = "principal",
        .resource = "resource",
    };
};
