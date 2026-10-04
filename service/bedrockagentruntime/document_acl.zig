const DocumentAclMembership = @import("document_acl_membership.zig").DocumentAclMembership;

/// The access control list for a document, containing allow and deny membership
/// lists. Each list specifies conditions that determine which users and groups
/// are granted or denied access.
pub const DocumentAcl = struct {
    /// The list of principals allowed access to the document.
    allow_list: ?DocumentAclMembership = null,

    /// The list of principals denied access to the document.
    deny_list: ?DocumentAclMembership = null,

    pub const json_field_names = .{
        .allow_list = "allowList",
        .deny_list = "denyList",
    };
};
