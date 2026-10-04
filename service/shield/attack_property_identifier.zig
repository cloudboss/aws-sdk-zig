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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
