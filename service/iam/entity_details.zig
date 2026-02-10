const EntityInfo = @import("entity_info.zig").EntityInfo;

/// An object that contains details about when the IAM entities (users or roles)
/// were last
/// used in an attempt to access the specified Amazon Web Services service.
///
/// This data type is a response element in the
/// [GetServiceLastAccessedDetailsWithEntities](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetailsWithEntities.html) operation.
pub const EntityDetails = struct {
    /// The `EntityInfo` object that contains details about the entity (user or
    /// role).
    entity_info: EntityInfo,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the authenticated entity last
    /// attempted to access Amazon Web Services. Amazon Web Services does
    /// not report unauthenticated requests.
    ///
    /// This field is null if no IAM entities attempted to access the service within
    /// the
    /// [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    last_authenticated: ?i64,
};
