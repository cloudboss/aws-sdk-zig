const PrincipalType = @import("principal_type.zig").PrincipalType;
const ServiceOptions = @import("service_options.zig").ServiceOptions;

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

    /// The options for the service, including the supported Regions for the
    /// endpoint
    /// access.
    service_options: ?ServiceOptions = null,

    pub const json_field_names = .{
        .principal = "Principal",
        .principal_type = "PrincipalType",
        .service_options = "ServiceOptions",
    };
};
