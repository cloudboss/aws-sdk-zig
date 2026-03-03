const statusType = @import("status_type.zig").statusType;

/// Contains additional details about a service-specific credential.
pub const ServiceSpecificCredentialMetadata = struct {
    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the service-specific
    /// credential were created.
    create_date: i64,

    /// The date and time when the service specific credential expires. This field
    /// is only
    /// present for Bedrock API keys that were created with an expiration period.
    expiration_date: ?i64 = null,

    /// For Bedrock API keys, this is the public portion of the credential that
    /// includes the IAM
    /// user name and a suffix containing version and creation information.
    service_credential_alias: ?[]const u8 = null,

    /// The name of the service associated with the service-specific credential.
    service_name: []const u8,

    /// The unique identifier for the service-specific credential.
    service_specific_credential_id: []const u8,

    /// The generated user name for the service-specific credential.
    service_user_name: []const u8 = "",

    /// The status of the service-specific credential. `Active` means that the key
    /// is
    /// valid for API calls, while `Inactive` means it is not.
    status: statusType,

    /// The name of the IAM user associated with the service-specific credential.
    user_name: []const u8,
};
