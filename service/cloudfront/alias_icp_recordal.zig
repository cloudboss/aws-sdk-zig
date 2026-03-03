const ICPRecordalStatus = @import("icp_recordal_status.zig").ICPRecordalStatus;

/// Amazon Web Services services in China customers must file for an Internet
/// Content Provider (ICP) recordal if they want to serve content publicly on an
/// alternate domain name, also known as a CNAME, that they've added to
/// CloudFront. AliasICPRecordal provides the ICP recordal status for CNAMEs
/// associated with distributions. The status is returned in the CloudFront
/// response; you can't configure it yourself.
///
/// For more information about ICP recordals, see [ Signup, Accounts, and
/// Credentials](https://docs.amazonaws.cn/en_us/aws/latest/userguide/accounts-and-credentials.html) in *Getting Started with Amazon Web Services services in China*.
pub const AliasICPRecordal = struct {
    /// A domain name associated with a distribution.
    cname: ?[]const u8 = null,

    /// The Internet Content Provider (ICP) recordal status for a CNAME. The
    /// ICPRecordalStatus is set to APPROVED for all CNAMEs (aliases) in Amazon Web
    /// Services Regions outside of China.
    ///
    /// The status values returned are the following:
    ///
    /// * **APPROVED** indicates that the associated CNAME has a valid ICP recordal
    ///   number. Multiple CNAMEs can be associated with a distribution, and CNAMEs
    ///   can correspond to different ICP recordals. To be marked as APPROVED, that
    ///   is, valid to use with the China Regions, a CNAME must have one ICP
    ///   recordal number associated with it.
    /// * **SUSPENDED** indicates that the associated CNAME does not have a valid
    ///   ICP recordal number.
    /// * **PENDING** indicates that CloudFront can't determine the ICP recordal
    ///   status of the CNAME associated with the distribution because there was an
    ///   error in trying to determine the status. You can try again to see if the
    ///   error is resolved in which case CloudFront returns an APPROVED or
    ///   SUSPENDED status.
    icp_recordal_status: ?ICPRecordalStatus = null,
};
