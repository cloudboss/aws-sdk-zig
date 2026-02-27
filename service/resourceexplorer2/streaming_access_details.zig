/// Contains information about an Amazon Web Services service that has been
/// granted streaming access to your Resource Explorer data.
pub const StreamingAccessDetails = struct {
    /// The date and time when streaming access was granted to the Amazon Web
    /// Services service, in ISO 8601 format.
    created_at: i64,

    /// The service principal of the Amazon Web Services service that has streaming
    /// access to your Resource Explorer data. A service principal is a unique
    /// identifier for an Amazon Web Services service.
    service_principal: []const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .service_principal = "ServicePrincipal",
    };
};
