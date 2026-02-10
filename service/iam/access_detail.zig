/// An object that contains details about when a principal in the reported
/// Organizations entity
/// last attempted to access an Amazon Web Services service. A principal can be
/// an IAM user, an IAM role,
/// or the Amazon Web Services account root user within the reported
/// Organizations entity.
///
/// This data type is a response element in the
/// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html) operation.
pub const AccessDetail = struct {
    /// The path of the Organizations entity (root, organizational unit, or account)
    /// from which an
    /// authenticated principal last attempted to access the service. Amazon Web
    /// Services does not report
    /// unauthenticated requests.
    ///
    /// This field is null if no principals (IAM users, IAM roles, or root user) in
    /// the
    /// reported Organizations entity attempted to access the service within the
    /// [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    entity_path: ?[]const u8,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when an authenticated principal
    /// most recently attempted to access the
    /// service. Amazon Web Services does not report unauthenticated requests.
    ///
    /// This field is null if no principals in the reported Organizations entity
    /// attempted to access the
    /// service within the [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    last_authenticated_time: ?i64,

    /// The Region where the last service access attempt occurred.
    ///
    /// This field is null if no principals in the reported Organizations entity
    /// attempted to access the
    /// service within the [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    region: ?[]const u8,

    /// The name of the service in which access was attempted.
    service_name: []const u8,

    /// The namespace of the service in which access was attempted.
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
    service_namespace: []const u8,

    /// The number of accounts with authenticated principals (root user, IAM users,
    /// and IAM
    /// roles) that attempted to access the service in the tracking period.
    total_authenticated_entities: ?i32,
};
