const ServiceAuthorization = @import("service_authorization.zig").ServiceAuthorization;

/// Configuration for enabling trusted identity propagation with Redshift
/// Connect.
pub const RedshiftConnect = struct {
    /// The authorization status for Redshift Connect. Valid values are ENABLED or
    /// DISABLED.
    authorization: ServiceAuthorization,

    pub const json_field_names = .{
        .authorization = "Authorization",
    };
};
