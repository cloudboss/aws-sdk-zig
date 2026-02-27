/// The status of the ACL update
pub const ACLsUpdateStatus = struct {
    /// A list of ACLs pending to be applied.
    acl_to_apply: ?[]const u8,

    pub const json_field_names = .{
        .acl_to_apply = "ACLToApply",
    };
};
