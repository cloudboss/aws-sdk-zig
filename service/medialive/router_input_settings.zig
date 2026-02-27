const RouterDestination = @import("router_destination.zig").RouterDestination;
const RouterEncryptionType = @import("router_encryption_type.zig").RouterEncryptionType;

/// The settings for a MediaConnect Router Input.
pub const RouterInputSettings = struct {
    /// MediaConnect Router destinations associated with the MediaLive Input.
    destinations: ?[]const RouterDestination,

    encryption_type: ?RouterEncryptionType,

    /// ARN of the secret used to encrypt this input.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .encryption_type = "EncryptionType",
        .secret_arn = "SecretArn",
    };
};
