const std = @import("std");

pub const RRType = enum {
    soa,
    a,
    txt,
    ns,
    cname,
    mx,
    naptr,
    ptr,
    srv,
    spf,
    aaaa,
    caa,
    ds,
    tlsa,
    sshfp,
    svcb,
    https,

    pub const json_field_names = .{
        .soa = "SOA",
        .a = "A",
        .txt = "TXT",
        .ns = "NS",
        .cname = "CNAME",
        .mx = "MX",
        .naptr = "NAPTR",
        .ptr = "PTR",
        .srv = "SRV",
        .spf = "SPF",
        .aaaa = "AAAA",
        .caa = "CAA",
        .ds = "DS",
        .tlsa = "TLSA",
        .sshfp = "SSHFP",
        .svcb = "SVCB",
        .https = "HTTPS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .soa => "SOA",
            .a => "A",
            .txt => "TXT",
            .ns => "NS",
            .cname => "CNAME",
            .mx => "MX",
            .naptr => "NAPTR",
            .ptr => "PTR",
            .srv => "SRV",
            .spf => "SPF",
            .aaaa => "AAAA",
            .caa => "CAA",
            .ds => "DS",
            .tlsa => "TLSA",
            .sshfp => "SSHFP",
            .svcb => "SVCB",
            .https => "HTTPS",
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
