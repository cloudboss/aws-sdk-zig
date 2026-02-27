/// A structure containing the Lake Formation audit context.
pub const AuditContext = struct {
    /// A string containing the additional audit context information.
    additional_audit_context: ?[]const u8,

    /// All columns request for audit.
    all_columns_requested: ?bool,

    /// The requested columns for audit.
    requested_columns: ?[]const []const u8,

    pub const json_field_names = .{
        .additional_audit_context = "AdditionalAuditContext",
        .all_columns_requested = "AllColumnsRequested",
        .requested_columns = "RequestedColumns",
    };
};
