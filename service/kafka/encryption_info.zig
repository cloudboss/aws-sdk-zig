const EncryptionAtRest = @import("encryption_at_rest.zig").EncryptionAtRest;
const EncryptionInTransit = @import("encryption_in_transit.zig").EncryptionInTransit;

/// Includes encryption-related information, such as the AWS KMS key used for
/// encrypting data at rest and whether you want MSK to encrypt your data in
/// transit.
pub const EncryptionInfo = struct {
    /// The data-volume encryption details.
    encryption_at_rest: ?EncryptionAtRest = null,

    /// The details for encryption in transit.
    encryption_in_transit: ?EncryptionInTransit = null,

    pub const json_field_names = .{
        .encryption_at_rest = "EncryptionAtRest",
        .encryption_in_transit = "EncryptionInTransit",
    };
};
