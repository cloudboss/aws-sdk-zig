const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes a static IP.
pub const StaticIp = struct {
    /// The Amazon Resource Name (ARN) of the static IP
    /// (`arn:aws:lightsail:us-east-2:123456789101:StaticIp/9cbb4a9e-f8e3-4dfe-b57e-12345EXAMPLE`).
    arn: ?[]const u8 = null,

    /// The instance where the static IP is attached
    /// (`Amazon_Linux-1GB-Ohio-1`).
    attached_to: ?[]const u8 = null,

    /// The timestamp when the static IP was created (`1479735304.222`).
    created_at: ?i64 = null,

    /// The static IP address.
    ip_address: ?[]const u8 = null,

    /// A Boolean value indicating whether the static IP is attached.
    is_attached: ?bool = null,

    /// The region and Availability Zone where the static IP was created.
    location: ?ResourceLocation = null,

    /// The name of the static IP (`StaticIP-Ohio-EXAMPLE`).
    name: ?[]const u8 = null,

    /// The resource type (usually `StaticIp`).
    resource_type: ?ResourceType = null,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// an instance or another resource in Lightsail. This code enables our support
    /// team to look up
    /// your Lightsail information more easily.
    support_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .attached_to = "attachedTo",
        .created_at = "createdAt",
        .ip_address = "ipAddress",
        .is_attached = "isAttached",
        .location = "location",
        .name = "name",
        .resource_type = "resourceType",
        .support_code = "supportCode",
    };
};
