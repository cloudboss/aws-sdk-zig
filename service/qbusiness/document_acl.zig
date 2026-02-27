const DocumentAclMembership = @import("document_acl_membership.zig").DocumentAclMembership;

/// Represents the Access Control List (ACL) for a document, containing both
/// allowlist and denylist conditions.
pub const DocumentAcl = struct {
    /// The allowlist conditions for the document. Users or groups matching these
    /// conditions are granted access to the document.
    allowlist: ?DocumentAclMembership,

    /// The denylist conditions for the document. Users or groups matching these
    /// conditions are denied access to the document, overriding allowlist
    /// permissions.
    deny_list: ?DocumentAclMembership,

    pub const json_field_names = .{
        .allowlist = "allowlist",
        .deny_list = "denyList",
    };
};
