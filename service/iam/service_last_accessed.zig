const TrackedActionLastAccessed = @import("tracked_action_last_accessed.zig").TrackedActionLastAccessed;

/// Contains details about the most recent attempt to access the service.
///
/// This data type is used as a response element in the
/// [GetServiceLastAccessedDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetails.html) operation.
pub const ServiceLastAccessed = struct {
    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when an authenticated entity most
    /// recently attempted to access the
    /// service. Amazon Web Services does not report unauthenticated requests.
    ///
    /// This field is null if no IAM entities attempted to access the service within
    /// the
    /// [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    last_authenticated: ?i64,

    /// The ARN of the authenticated entity (user or role) that last attempted to
    /// access the
    /// service. Amazon Web Services does not report unauthenticated requests.
    ///
    /// This field is null if no IAM entities attempted to access the service within
    /// the
    /// [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    last_authenticated_entity: ?[]const u8,

    /// The Region from which the authenticated entity (user or role) last attempted
    /// to access
    /// the service. Amazon Web Services does not report unauthenticated requests.
    ///
    /// This field is null if no IAM entities attempted to access the service within
    /// the
    /// [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    last_authenticated_region: ?[]const u8,

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
    /// Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces) in the *Amazon Web Services General Reference*.
    service_namespace: []const u8,

    /// The total number of authenticated principals (root user, IAM users, or IAM
    /// roles) that
    /// have attempted to access the service.
    ///
    /// This field is null if no principals attempted to access the service within
    /// the [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    total_authenticated_entities: ?i32,

    /// An object that contains details about the most recent attempt to access a
    /// tracked action
    /// within the service.
    ///
    /// This field is null if there no tracked actions or if the principal did not
    /// use the
    /// tracked actions within the [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period). This field is also null if the report was generated at the
    /// service level and not the action level. For more information, see the
    /// `Granularity` field in
    /// [GenerateServiceLastAccessedDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GenerateServiceLastAccessedDetails.html).
    tracked_actions_last_accessed: ?[]const TrackedActionLastAccessed,
};
