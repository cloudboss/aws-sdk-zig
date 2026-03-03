const InTransitEncryptionConfiguration = @import("in_transit_encryption_configuration.zig").InTransitEncryptionConfiguration;

/// Configurations related to encryption for the security configuration.
pub const EncryptionConfiguration = struct {
    /// In-transit encryption-related input for the security configuration.
    in_transit_encryption_configuration: ?InTransitEncryptionConfiguration = null,

    pub const json_field_names = .{
        .in_transit_encryption_configuration = "inTransitEncryptionConfiguration",
    };
};
