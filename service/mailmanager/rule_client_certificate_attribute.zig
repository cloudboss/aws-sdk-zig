const std = @import("std");

/// The client certificate attribute to evaluate in a rule condition. These
/// attributes are extracted from the client certificate presented during mutual
/// TLS authentication.
pub const RuleClientCertificateAttribute = enum {
    cn,
    san_rfc822_name,
    san_dns_name,
    san_directory_name,
    san_uniform_resource_identifier,
    san_ip_address,
    san_registered_id,
    serial_number,

    pub const json_field_names = .{
        .cn = "CN",
        .san_rfc822_name = "SAN_RFC822_NAME",
        .san_dns_name = "SAN_DNS_NAME",
        .san_directory_name = "SAN_DIRECTORY_NAME",
        .san_uniform_resource_identifier = "SAN_UNIFORM_RESOURCE_IDENTIFIER",
        .san_ip_address = "SAN_IP_ADDRESS",
        .san_registered_id = "SAN_REGISTERED_ID",
        .serial_number = "SERIAL_NUMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cn => "CN",
            .san_rfc822_name => "SAN_RFC822_NAME",
            .san_dns_name => "SAN_DNS_NAME",
            .san_directory_name => "SAN_DIRECTORY_NAME",
            .san_uniform_resource_identifier => "SAN_UNIFORM_RESOURCE_IDENTIFIER",
            .san_ip_address => "SAN_IP_ADDRESS",
            .san_registered_id => "SAN_REGISTERED_ID",
            .serial_number => "SERIAL_NUMBER",
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
