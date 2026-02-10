pub const IpamPublicAddressType = enum {
    service_managed_ip,
    service_managed_byoip,
    amazon_owned_eip,
    amazon_owned_contig,
    byoip,
    ec2_public_ip,
    anycast_ip_list_ip,
};
