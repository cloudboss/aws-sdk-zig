const RouterDestinationSettings = @import("router_destination_settings.zig").RouterDestinationSettings;
const RouterEncryptionType = @import("router_encryption_type.zig").RouterEncryptionType;

/// This is the collection of settings that are used during the creation of a
/// MediaConnect router input.
pub const RouterSettings = struct {
    /// Destinations for the input from MediaConnect Router. Provide one for a
    /// single-pipeline input and two for a standard input.
    destinations: ?[]const RouterDestinationSettings = null,

    encryption_type: ?RouterEncryptionType = null,

    /// ARN of the secret used to encrypt this input.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .encryption_type = "EncryptionType",
        .secret_arn = "SecretArn",
    };
};
