const std = @import("std");

pub const AttackPropertyIdentifier = enum {
    destination_url,
    referrer,
    source_asn,
    source_country,
    source_ip_address,
    source_user_agent,
    wordpress_pingback_reflector,
    wordpress_pingback_source,

    pub const json_field_names = .{
        .destination_url = "DESTINATION_URL",
        .referrer = "REFERRER",
        .source_asn = "SOURCE_ASN",
        .source_country = "SOURCE_COUNTRY",
        .source_ip_address = "SOURCE_IP_ADDRESS",
        .source_user_agent = "SOURCE_USER_AGENT",
        .wordpress_pingback_reflector = "WORDPRESS_PINGBACK_REFLECTOR",
        .wordpress_pingback_source = "WORDPRESS_PINGBACK_SOURCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .destination_url => "DESTINATION_URL",
            .referrer => "REFERRER",
            .source_asn => "SOURCE_ASN",
            .source_country => "SOURCE_COUNTRY",
            .source_ip_address => "SOURCE_IP_ADDRESS",
            .source_user_agent => "SOURCE_USER_AGENT",
            .wordpress_pingback_reflector => "WORDPRESS_PINGBACK_REFLECTOR",
            .wordpress_pingback_source => "WORDPRESS_PINGBACK_SOURCE",
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
