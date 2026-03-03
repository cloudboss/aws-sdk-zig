const std = @import("std");

pub const IpamPublicAddressType = enum {
    service_managed_ip,
    service_managed_byoip,
    amazon_owned_eip,
    amazon_owned_contig,
    byoip,
    ec2_public_ip,
    anycast_ip_list_ip,

    pub const json_field_names = .{
        .service_managed_ip = "service-managed-ip",
        .service_managed_byoip = "service-managed-byoip",
        .amazon_owned_eip = "amazon-owned-eip",
        .amazon_owned_contig = "amazon-owned-contig",
        .byoip = "byoip",
        .ec2_public_ip = "ec2-public-ip",
        .anycast_ip_list_ip = "anycast-ip-list-ip",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_managed_ip => "service-managed-ip",
            .service_managed_byoip => "service-managed-byoip",
            .amazon_owned_eip => "amazon-owned-eip",
            .amazon_owned_contig => "amazon-owned-contig",
            .byoip => "byoip",
            .ec2_public_ip => "ec2-public-ip",
            .anycast_ip_list_ip => "anycast-ip-list-ip",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
