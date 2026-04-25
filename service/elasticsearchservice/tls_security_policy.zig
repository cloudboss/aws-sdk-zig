const std = @import("std");

pub const TLSSecurityPolicy = enum {
    policy_min_tls_1_0_2019_07,
    policy_min_tls_1_2_2019_07,
    policy_min_tls_1_2_pfs_2023_10,
    policy_min_tls_1_2_rfc9151_fips_2024_08,

    pub const json_field_names = .{
        .policy_min_tls_1_0_2019_07 = "Policy-Min-TLS-1-0-2019-07",
        .policy_min_tls_1_2_2019_07 = "Policy-Min-TLS-1-2-2019-07",
        .policy_min_tls_1_2_pfs_2023_10 = "Policy-Min-TLS-1-2-PFS-2023-10",
        .policy_min_tls_1_2_rfc9151_fips_2024_08 = "Policy-Min-TLS-1-2-RFC9151-FIPS-2024-08",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .policy_min_tls_1_0_2019_07 => "Policy-Min-TLS-1-0-2019-07",
            .policy_min_tls_1_2_2019_07 => "Policy-Min-TLS-1-2-2019-07",
            .policy_min_tls_1_2_pfs_2023_10 => "Policy-Min-TLS-1-2-PFS-2023-10",
            .policy_min_tls_1_2_rfc9151_fips_2024_08 => "Policy-Min-TLS-1-2-RFC9151-FIPS-2024-08",
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
