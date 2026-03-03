const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

/// Specifies a security configuration.
pub const SecurityConfiguration = struct {
    /// The time at which this security configuration was created.
    created_time_stamp: ?i64 = null,

    /// The encryption configuration associated with this security configuration.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The name of the security configuration.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_time_stamp = "CreatedTimeStamp",
        .encryption_configuration = "EncryptionConfiguration",
        .name = "Name",
    };
};
