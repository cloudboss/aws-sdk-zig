const Condition = @import("condition.zig").Condition;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;

/// A structure that describes the attachment of a row-level security policy to
/// a resource for a principal.
pub const RLSPolicyAttachment = struct {
    /// The identifier for the Data Catalog that contains the attachment. By
    /// default, the account ID.
    catalog_id: ?[]const u8 = null,

    /// A Lake Formation condition, which applies to the row-level security policy
    /// attachment and contains an expression.
    condition: ?Condition = null,

    /// Indicates whether this attachment is the default row-level security policy
    /// for the resource.
    default_rls_policy: ?bool = null,

    /// The name of the attached row-level security policy.
    policy_name: ?[]const u8 = null,

    /// The principal to which the attached policy applies.
    principal: ?DataLakePrincipal = null,

    /// The resource to which the policy is attached.
    resource: ?Resource = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .condition = "Condition",
        .default_rls_policy = "DefaultRLSPolicy",
        .policy_name = "PolicyName",
        .principal = "Principal",
        .resource = "Resource",
    };
};
