/// Contains information about the last time that an IAM role was used. This
/// includes the
/// date and time and the Region in which the role was last used. Activity is
/// only reported for
/// the trailing 400 days. This period can be shorter if your Region began
/// supporting these
/// features within the last year. The role might have been used more than 400
/// days ago. For
/// more information, see [Regions where data is
/// tracked](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#access-advisor_tracking-period) in the *IAM user
/// Guide*.
///
/// This data type is returned as a response element in the
/// [GetRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRole.html) and [GetAccountAuthorizationDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountAuthorizationDetails.html) operations.
pub const RoleLastUsed = struct {
    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601) that the role was last used.
    ///
    /// This field is null if the role has not been used within the IAM tracking
    /// period. For
    /// more information about the tracking period, see [Regions where data is
    /// tracked](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#access-advisor_tracking-period) in the *IAM User Guide*.
    last_used_date: ?i64,

    /// The name of the Amazon Web Services Region in which the role was last used.
    region: ?[]const u8,
};
