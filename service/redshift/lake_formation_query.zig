const ServiceAuthorization = @import("service_authorization.zig").ServiceAuthorization;

/// The Lake Formation scope.
pub const LakeFormationQuery = struct {
    /// Determines whether the query scope is enabled or disabled.
    authorization: ServiceAuthorization,
};
