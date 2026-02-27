/// Contains details about a policy template
///
/// This data type is used as a response parameter for the
/// [ListPolicyTemplates](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicyTemplates.html) operation.
pub const PolicyTemplateItem = struct {
    /// The date and time that the policy template was created.
    created_date: i64,

    /// The description attached to the policy template.
    description: ?[]const u8,

    /// The date and time that the policy template was most recently updated.
    last_updated_date: i64,

    /// The unique identifier of the policy store that contains the template.
    policy_store_id: []const u8,

    /// The unique identifier of the policy template.
    policy_template_id: []const u8,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
        .policy_template_id = "policyTemplateId",
    };
};
