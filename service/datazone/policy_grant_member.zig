const PolicyGrantDetail = @import("policy_grant_detail.zig").PolicyGrantDetail;
const PolicyGrantPrincipal = @import("policy_grant_principal.zig").PolicyGrantPrincipal;

/// A member of the policy grant list.
pub const PolicyGrantMember = struct {
    /// Specifies the timestamp at which policy grant member was created.
    created_at: ?i64 = null,

    /// Specifies the user who created the policy grant member.
    created_by: ?[]const u8 = null,

    /// The details of the policy grant member.
    detail: ?PolicyGrantDetail = null,

    /// The ID of the policy grant.
    grant_id: ?[]const u8 = null,

    /// The principal of the policy grant member.
    principal: ?PolicyGrantPrincipal = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .detail = "detail",
        .grant_id = "grantId",
        .principal = "principal",
    };
};
