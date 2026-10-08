const std = @import("std");

/// Method used to verify domain ownership.
pub const DomainVerificationMethod = enum {
    /// Verify ownership via DNS TXT record.
    dns_txt,
    /// Verify ownership via HTTP route.
    http_route,
    /// Verify ownership via IP for private VPC pentests.
    private_vpc,

    pub const json_field_names = .{
        .dns_txt = "DNS_TXT",
        .http_route = "HTTP_ROUTE",
        .private_vpc = "PRIVATE_VPC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dns_txt => "DNS_TXT",
            .http_route => "HTTP_ROUTE",
            .private_vpc => "PRIVATE_VPC",
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
