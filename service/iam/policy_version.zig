/// Contains information about a version of a managed policy.
///
/// This data type is used as a response element in the
/// [CreatePolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreatePolicyVersion.html),
/// [GetPolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicyVersion.html), [ListPolicyVersions](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPolicyVersions.html),
/// and
/// [GetAccountAuthorizationDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountAuthorizationDetails.html) operations.
///
/// For more information about managed policies, refer to [Managed policies and
/// inline
/// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
pub const PolicyVersion = struct {
    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the policy version was
    /// created.
    create_date: ?i64,

    /// The policy document.
    ///
    /// The policy document is returned in the response to the
    /// [GetPolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetPolicyVersion.html) and
    /// [GetAccountAuthorizationDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountAuthorizationDetails.html) operations. It is not returned in the response
    /// to the
    /// [CreatePolicyVersion](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreatePolicyVersion.html)
    /// or
    /// [ListPolicyVersions](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPolicyVersions.html) operations.
    ///
    /// The policy document returned in this structure is URL-encoded compliant with
    /// [RFC 3986](https://tools.ietf.org/html/rfc3986). You can use a URL decoding
    /// method to convert the policy back to plain JSON text. For example, if you
    /// use Java, you can
    /// use the `decode` method of the `java.net.URLDecoder` utility class in
    /// the Java SDK. Other languages and SDKs provide similar functionality.
    document: ?[]const u8,

    /// Specifies whether the policy version is set as the policy's default version.
    is_default_version: bool = false,

    /// The identifier for the policy version.
    ///
    /// Policy version identifiers always begin with `v` (always lowercase). When a
    /// policy is created, the first policy version is `v1`.
    version_id: ?[]const u8,
};
