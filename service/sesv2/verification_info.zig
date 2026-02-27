const VerificationError = @import("verification_error.zig").VerificationError;
const SOARecord = @import("soa_record.zig").SOARecord;

/// An object that contains additional information about the verification status
/// for the
/// identity.
pub const VerificationInfo = struct {
    /// Provides the reason for the failure describing why Amazon SES was not able
    /// to successfully
    /// verify the identity. Below are the possible values:
    ///
    /// * `INVALID_VALUE` – Amazon SES was able to find the record, but the
    /// value contained within the record was invalid. Ensure you have published the
    /// correct values for the record.
    ///
    /// * `TYPE_NOT_FOUND` – The queried hostname exists but does not
    /// have the requested type of DNS record. Ensure that you have published the
    /// correct type of DNS record.
    ///
    /// * `HOST_NOT_FOUND` – The queried hostname does not exist or was
    /// not reachable at the time of the request. Ensure that you have published the
    /// required DNS record(s).
    ///
    /// * `SERVICE_ERROR` – A temporary issue is preventing Amazon SES from
    /// determining the verification status of the domain.
    ///
    /// * `DNS_SERVER_ERROR` – The DNS server encountered an issue and
    /// was unable to complete the request.
    ///
    /// * `REPLICATION_ACCESS_DENIED` – The verification failed because the user
    ///   does not
    /// have the required permissions to replicate the DKIM key from the primary
    /// region. Ensure you have the
    /// necessary permissions in both primary and replica regions.
    ///
    /// * `REPLICATION_PRIMARY_NOT_FOUND` – The verification failed because no
    ///   corresponding
    /// identity was found in the specified primary region. Ensure the identity
    /// exists in the primary region
    /// before attempting replication.
    ///
    /// * `REPLICATION_PRIMARY_BYO_DKIM_NOT_SUPPORTED` – The verification failed
    ///   because the
    /// identity in the primary region is configured with Bring Your Own DKIM
    /// (BYODKIM). DKIM key
    /// replication is only supported for identities using Easy DKIM.
    ///
    /// * `REPLICATION_REPLICA_AS_PRIMARY_NOT_SUPPORTED` – The verification failed
    ///   because
    /// the specified primary identity is a replica of another identity, and
    /// multi-level replication is not
    /// supported; the primary identity must be a non-replica identity.
    ///
    /// * `REPLICATION_PRIMARY_INVALID_REGION` – The verification failed due to an
    ///   invalid
    /// primary region specified. Ensure you provide a valid Amazon Web Services
    /// region where Amazon SES is available and different
    /// from the replica region.
    error_type: ?VerificationError,

    /// The last time a verification attempt was made for this identity.
    last_checked_timestamp: ?i64,

    /// The last time a successful verification was made for this identity.
    last_success_timestamp: ?i64,

    /// An object that contains information about the start of authority (SOA)
    /// record
    /// associated with the identity.
    soa_record: ?SOARecord,

    pub const json_field_names = .{
        .error_type = "ErrorType",
        .last_checked_timestamp = "LastCheckedTimestamp",
        .last_success_timestamp = "LastSuccessTimestamp",
        .soa_record = "SOARecord",
    };
};
