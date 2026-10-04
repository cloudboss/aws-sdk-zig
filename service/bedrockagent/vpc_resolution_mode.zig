const std = @import("std");

/// Controls how a domain-name resource target is resolved. This applies only
/// when the target is a domain name; it has no effect for IP-address targets.
/// In all cases the resolved address must be reachable from inside the VPC.
/// Valid values:
///
/// * `IN_VPC` (default, recommended) – The target domain name is resolved
///   privately, using the DNS resolvers of the VPC.
/// * `PUBLIC` – The target domain name is resolved against public DNS
///   resolvers, for the uncommon case where the name must resolve through
///   public DNS but the resulting address remains reachable from the VPC.
pub const VpcResolutionMode = enum {
    public,
    in_vpc,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .in_vpc = "IN_VPC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public => "PUBLIC",
            .in_vpc => "IN_VPC",
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
