const DomainType = @import("domain_type.zig").DomainType;
const ServiceManaged = @import("service_managed.zig").ServiceManaged;
const Tag = @import("tag.zig").Tag;

/// Describes an Elastic IP address, or a carrier IP address.
pub const Address = struct {
    /// The ID representing the allocation of the address.
    allocation_id: ?[]const u8 = null,

    /// The ID representing the association of the address with an instance.
    association_id: ?[]const u8 = null,

    /// The carrier IP address associated. This option is only available for network
    /// interfaces
    /// which reside in a subnet in a Wavelength Zone (for example an EC2 instance).
    carrier_ip: ?[]const u8 = null,

    /// The customer-owned IP address.
    customer_owned_ip: ?[]const u8 = null,

    /// The ID of the customer-owned address pool.
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// The network (`vpc`).
    domain: ?DomainType = null,

    /// The ID of the instance that the address is associated with (if any).
    instance_id: ?[]const u8 = null,

    /// The name of the unique set of Availability Zones, Local Zones, or Wavelength
    /// Zones from
    /// which Amazon Web Services advertises IP addresses.
    network_border_group: ?[]const u8 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the network interface.
    network_interface_owner_id: ?[]const u8 = null,

    /// The private IP address associated with the Elastic IP address.
    private_ip_address: ?[]const u8 = null,

    /// The Elastic IP address.
    public_ip: ?[]const u8 = null,

    /// The ID of an address pool.
    public_ipv_4_pool: ?[]const u8 = null,

    /// The service that manages the elastic IP address.
    ///
    /// The only option supported today is `alb`.
    service_managed: ?ServiceManaged = null,

    /// The ID of the subnet where the IP address is allocated.
    subnet_id: ?[]const u8 = null,

    /// Any tags assigned to the Elastic IP address.
    tags: ?[]const Tag = null,
};
