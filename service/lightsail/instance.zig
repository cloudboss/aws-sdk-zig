const AddOn = @import("add_on.zig").AddOn;
const InstanceHardware = @import("instance_hardware.zig").InstanceHardware;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const InstanceMetadataOptions = @import("instance_metadata_options.zig").InstanceMetadataOptions;
const InstanceNetworking = @import("instance_networking.zig").InstanceNetworking;
const ResourceType = @import("resource_type.zig").ResourceType;
const InstanceState = @import("instance_state.zig").InstanceState;
const Tag = @import("tag.zig").Tag;

/// Describes an instance (a virtual private server).
pub const Instance = struct {
    /// An array of objects representing the add-ons enabled on the instance.
    add_ons: ?[]const AddOn = null,

    /// The Amazon Resource Name (ARN) of the instance
    /// (`arn:aws:lightsail:us-east-2:123456789101:Instance/244ad76f-8aad-4741-809f-12345EXAMPLE`).
    arn: ?[]const u8 = null,

    /// The blueprint ID (`amazon_linux_2023`).
    blueprint_id: ?[]const u8 = null,

    /// The friendly name of the blueprint (`Amazon Linux 2023`).
    blueprint_name: ?[]const u8 = null,

    /// The bundle for the instance (`micro_x_x`).
    bundle_id: ?[]const u8 = null,

    /// The timestamp when the instance was created (`1479734909.17`) in Unix time
    /// format.
    created_at: ?i64 = null,

    /// The size of the vCPU and the amount of RAM for the instance.
    hardware: ?InstanceHardware = null,

    /// The IP address type of the instance.
    ///
    /// The possible values are `ipv4` for IPv4 only, `ipv6` for IPv6 only,
    /// and `dualstack` for IPv4 and IPv6.
    ip_address_type: ?IpAddressType = null,

    /// The IPv6 addresses of the instance.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// A Boolean value indicating whether this instance has a static IP assigned to
    /// it.
    is_static_ip: ?bool = null,

    /// The region name and Availability Zone where the instance is located.
    location: ?ResourceLocation = null,

    /// The metadata options for the Amazon Lightsail instance.
    metadata_options: ?InstanceMetadataOptions = null,

    /// The name the user gave the instance (`Amazon_Linux_2023-1`).
    name: ?[]const u8 = null,

    /// Information about the public ports and monthly data transfer rates for the
    /// instance.
    networking: ?InstanceNetworking = null,

    /// The private IP address of the instance.
    private_ip_address: ?[]const u8 = null,

    /// The public IP address of the instance.
    public_ip_address: ?[]const u8 = null,

    /// The type of resource (usually `Instance`).
    resource_type: ?ResourceType = null,

    /// The name of the SSH key being used to connect to the instance
    /// (`LightsailDefaultKeyPair`).
    ssh_key_name: ?[]const u8 = null,

    /// The status code and the state (`running`) for the instance.
    state: ?InstanceState = null,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// an instance or another resource in Lightsail. This code enables our support
    /// team to look up
    /// your Lightsail information more easily.
    support_code: ?[]const u8 = null,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag = null,

    /// The user name for connecting to the instance (`ec2-user`).
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .add_ons = "addOns",
        .arn = "arn",
        .blueprint_id = "blueprintId",
        .blueprint_name = "blueprintName",
        .bundle_id = "bundleId",
        .created_at = "createdAt",
        .hardware = "hardware",
        .ip_address_type = "ipAddressType",
        .ipv_6_addresses = "ipv6Addresses",
        .is_static_ip = "isStaticIp",
        .location = "location",
        .metadata_options = "metadataOptions",
        .name = "name",
        .networking = "networking",
        .private_ip_address = "privateIpAddress",
        .public_ip_address = "publicIpAddress",
        .resource_type = "resourceType",
        .ssh_key_name = "sshKeyName",
        .state = "state",
        .support_code = "supportCode",
        .tags = "tags",
        .username = "username",
    };
};
