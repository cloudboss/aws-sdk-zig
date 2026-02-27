const ServiceAuthorization = @import("service_authorization.zig").ServiceAuthorization;

/// A structure that defines the Amazon Redshift connect service integration
/// scope.
pub const Connect = struct {
    /// Determines whether the Amazon Redshift connect integration is enabled or
    /// disabled for the application.
    authorization: ServiceAuthorization,
};
