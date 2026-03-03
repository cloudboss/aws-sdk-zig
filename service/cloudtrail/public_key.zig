/// Contains information about a returned public key.
pub const PublicKey = struct {
    /// The fingerprint of the public key.
    fingerprint: ?[]const u8 = null,

    /// The ending time of validity of the public key.
    validity_end_time: ?i64 = null,

    /// The starting time of validity of the public key.
    validity_start_time: ?i64 = null,

    /// The DER encoded public key value in PKCS#1 format.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .fingerprint = "Fingerprint",
        .validity_end_time = "ValidityEndTime",
        .validity_start_time = "ValidityStartTime",
        .value = "Value",
    };
};
