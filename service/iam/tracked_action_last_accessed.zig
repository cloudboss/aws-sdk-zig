/// Contains details about the most recent attempt to access an action within
/// the
/// service.
///
/// This data type is used as a response element in the
/// [GetServiceLastAccessedDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetails.html) operation.
pub const TrackedActionLastAccessed = struct {
    /// The name of the tracked action to which access was attempted. Tracked
    /// actions are
    /// actions that report activity to IAM.
    action_name: ?[]const u8 = null,

    last_accessed_entity: ?[]const u8 = null,

    /// The Region from which the authenticated entity (user or role) last attempted
    /// to access
    /// the tracked action. Amazon Web Services does not report unauthenticated
    /// requests.
    ///
    /// This field is null if no IAM entities attempted to access the service within
    /// the
    /// [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    last_accessed_region: ?[]const u8 = null,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when an authenticated entity most
    /// recently attempted to access the
    /// tracked service. Amazon Web Services does not report unauthenticated
    /// requests.
    ///
    /// This field is null if no IAM entities attempted to access the service within
    /// the
    /// [tracking
    /// period](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#service-last-accessed-reporting-period).
    last_accessed_time: ?i64 = null,
};
