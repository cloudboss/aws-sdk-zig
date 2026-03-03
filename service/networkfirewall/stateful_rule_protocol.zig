const std = @import("std");

pub const StatefulRuleProtocol = enum {
    any,
    tcp,
    udp,
    icmp,
    http,
    ftp,
    tls,
    smb,
    dns,
    dcerpc,
    ssh,
    smtp,
    imap,
    msn,
    krb5,
    ikev2,
    tftp,
    ntp,
    dhcp,
    http2,
    quic,

    pub const json_field_names = .{
        .any = "IP",
        .tcp = "TCP",
        .udp = "UDP",
        .icmp = "ICMP",
        .http = "HTTP",
        .ftp = "FTP",
        .tls = "TLS",
        .smb = "SMB",
        .dns = "DNS",
        .dcerpc = "DCERPC",
        .ssh = "SSH",
        .smtp = "SMTP",
        .imap = "IMAP",
        .msn = "MSN",
        .krb5 = "KRB5",
        .ikev2 = "IKEV2",
        .tftp = "TFTP",
        .ntp = "NTP",
        .dhcp = "DHCP",
        .http2 = "HTTP2",
        .quic = "QUIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .any => "IP",
            .tcp => "TCP",
            .udp => "UDP",
            .icmp => "ICMP",
            .http => "HTTP",
            .ftp => "FTP",
            .tls => "TLS",
            .smb => "SMB",
            .dns => "DNS",
            .dcerpc => "DCERPC",
            .ssh => "SSH",
            .smtp => "SMTP",
            .imap => "IMAP",
            .msn => "MSN",
            .krb5 => "KRB5",
            .ikev2 => "IKEV2",
            .tftp => "TFTP",
            .ntp => "NTP",
            .dhcp => "DHCP",
            .http2 => "HTTP2",
            .quic => "QUIC",
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
