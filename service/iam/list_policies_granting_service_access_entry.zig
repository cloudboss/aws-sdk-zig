const PolicyGrantingServiceAccess = @import("policy_granting_service_access.zig").PolicyGrantingServiceAccess;

/// Contains details about the permissions policies that are attached to the
/// specified
/// identity (user, group, or role).
///
/// This data type is used as a response element in the
/// [ListPoliciesGrantingServiceAccess](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPoliciesGrantingServiceAccess.html) operation.
pub const ListPoliciesGrantingServiceAccessEntry = struct {
    /// The `PoliciesGrantingServiceAccess` object that contains details about the
    /// policy.
    policies: ?[]const PolicyGrantingServiceAccess,

    /// The namespace of the service that was accessed.
    ///
    /// To learn the service namespace of a service, see [Actions, resources, and
    /// condition keys for Amazon Web Services
    /// services](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html) in the
    /// *Service Authorization Reference*. Choose the name of the service to
    /// view details for that service. In the first paragraph, find the service
    /// prefix. For
    /// example, `(service prefix: a4b)`. For more information about service
    /// namespaces,
    /// see [Amazon Web Services
    /// service
    /// namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces) in the *Amazon Web Services General Reference*.
    service_namespace: ?[]const u8,
};
