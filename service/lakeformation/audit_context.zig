/// A structure used to include auditing information on the privileged API.
pub const AuditContext = struct {
    /// The filter engine can populate the 'AdditionalAuditContext' information with
    /// the request ID for you to track. This information will be displayed in
    /// CloudTrail log in your account.
    additional_audit_context: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_audit_context = "AdditionalAuditContext",
    };
};
