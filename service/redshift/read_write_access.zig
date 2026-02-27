const ServiceAuthorization = @import("service_authorization.zig").ServiceAuthorization;

/// The S3 Access Grants scope.
pub const ReadWriteAccess = struct {
    /// Determines whether the read/write scope is enabled or disabled.
    authorization: ServiceAuthorization,
};
