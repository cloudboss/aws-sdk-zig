const PrincipalType = @import("principal_type.zig").PrincipalType;

/// Information about an Amazon Web Services account or service that has access
/// to an
/// Amazon OpenSearch Service domain through the use of an interface VPC
/// endpoint.
pub const AuthorizedPrincipal = struct {
    /// The [IAM
    /// principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html) that is allowed access to the domain.
    principal: ?[]const u8 = null,

    /// The type of principal.
    principal_type: ?PrincipalType = null,

    pub const json_field_names = .{
        .principal = "Principal",
        .principal_type = "PrincipalType",
    };
};
