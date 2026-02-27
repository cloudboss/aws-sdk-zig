const PrincipalType = @import("principal_type.zig").PrincipalType;

/// Information about an account or service that has access to an Amazon
/// OpenSearch Service domain through the use of an interface VPC endpoint.
pub const AuthorizedPrincipal = struct {
    /// The IAM principal that is allowed access to the domain.
    principal: ?[]const u8,

    /// The type of principal.
    principal_type: ?PrincipalType,

    pub const json_field_names = .{
        .principal = "Principal",
        .principal_type = "PrincipalType",
    };
};
