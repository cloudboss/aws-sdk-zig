const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// Describes an SSH key pair.
pub const KeyPair = struct {
    /// The Amazon Resource Name (ARN) of the key pair
    /// (`arn:aws:lightsail:us-east-2:123456789101:KeyPair/05859e3d-331d-48ba-9034-12345EXAMPLE`).
    arn: ?[]const u8,

    /// The timestamp when the key pair was created (`1479816991.349`).
    created_at: ?i64,

    /// The RSA fingerprint of the key pair.
    fingerprint: ?[]const u8,

    /// The region name and Availability Zone where the key pair was created.
    location: ?ResourceLocation,

    /// The friendly name of the SSH key pair.
    name: ?[]const u8,

    /// The resource type (usually `KeyPair`).
    resource_type: ?ResourceType,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// an instance or another resource in Lightsail. This code enables our support
    /// team to look up
    /// your Lightsail information more easily.
    support_code: ?[]const u8,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .fingerprint = "fingerprint",
        .location = "location",
        .name = "name",
        .resource_type = "resourceType",
        .support_code = "supportCode",
        .tags = "tags",
    };
};
