/// A string representing the status of DNSSEC signing.
pub const DNSSECStatus = struct {
    /// A string that represents the current hosted zone signing status.
    ///
    /// Status can have one of the following values:
    ///
    /// **SIGNING**
    ///
    /// DNSSEC signing is enabled for the hosted zone.
    ///
    /// **NOT_SIGNING**
    ///
    /// DNSSEC signing is not enabled for the hosted zone.
    ///
    /// **DELETING**
    ///
    /// DNSSEC signing is in the process of being removed for the hosted
    /// zone.
    ///
    /// **ACTION_NEEDED**
    ///
    /// There is a problem with signing in the hosted zone that requires you to
    /// take action to resolve. For example, the customer managed key might have
    /// been deleted, or the permissions for the customer managed key might have
    /// been changed.
    ///
    /// **INTERNAL_FAILURE**
    ///
    /// There was an error during a request. Before you can continue to work with
    /// DNSSEC signing, including with key-signing keys (KSKs), you must correct the
    /// problem by enabling or disabling DNSSEC signing for the hosted zone.
    serve_signature: ?[]const u8,

    /// The status message provided for the following DNSSEC signing status:
    /// `INTERNAL_FAILURE`. The status message includes information about what
    /// the problem might be and steps that you can take to correct the issue.
    status_message: ?[]const u8,
};
