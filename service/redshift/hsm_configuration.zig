const Tag = @import("tag.zig").Tag;

/// Returns information about an HSM configuration, which is an object that
/// describes
/// to Amazon Redshift clusters the information they require to connect to an
/// HSM where they can
/// store database encryption keys.
pub const HsmConfiguration = struct {
    /// A text description of the HSM configuration.
    description: ?[]const u8,

    /// The name of the Amazon Redshift HSM configuration.
    hsm_configuration_identifier: ?[]const u8,

    /// The IP address that the Amazon Redshift cluster must use to access the HSM.
    hsm_ip_address: ?[]const u8,

    /// The name of the partition in the HSM where the Amazon Redshift clusters will
    /// store their
    /// database encryption keys.
    hsm_partition_name: ?[]const u8,

    /// The list of tags for the HSM configuration.
    tags: ?[]const Tag,
};
