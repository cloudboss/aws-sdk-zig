const std = @import("std");

pub const IndicatorType = enum {
    suspicious_user_agent,
    suspicious_network,
    malicious_ip,
    tor_ip,
    attack_tactic,
    high_risk_api,
    attack_technique,
    unusual_api_for_account,
    unusual_asn_for_account,
    unusual_asn_for_user,
    suspicious_process,
    malicious_domain,
    malicious_process,
    cryptomining_ip,
    cryptomining_domain,
    cryptomining_process,
    malicious_file,

    pub const json_field_names = .{
        .suspicious_user_agent = "SUSPICIOUS_USER_AGENT",
        .suspicious_network = "SUSPICIOUS_NETWORK",
        .malicious_ip = "MALICIOUS_IP",
        .tor_ip = "TOR_IP",
        .attack_tactic = "ATTACK_TACTIC",
        .high_risk_api = "HIGH_RISK_API",
        .attack_technique = "ATTACK_TECHNIQUE",
        .unusual_api_for_account = "UNUSUAL_API_FOR_ACCOUNT",
        .unusual_asn_for_account = "UNUSUAL_ASN_FOR_ACCOUNT",
        .unusual_asn_for_user = "UNUSUAL_ASN_FOR_USER",
        .suspicious_process = "SUSPICIOUS_PROCESS",
        .malicious_domain = "MALICIOUS_DOMAIN",
        .malicious_process = "MALICIOUS_PROCESS",
        .cryptomining_ip = "CRYPTOMINING_IP",
        .cryptomining_domain = "CRYPTOMINING_DOMAIN",
        .cryptomining_process = "CRYPTOMINING_PROCESS",
        .malicious_file = "MALICIOUS_FILE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .suspicious_user_agent => "SUSPICIOUS_USER_AGENT",
            .suspicious_network => "SUSPICIOUS_NETWORK",
            .malicious_ip => "MALICIOUS_IP",
            .tor_ip => "TOR_IP",
            .attack_tactic => "ATTACK_TACTIC",
            .high_risk_api => "HIGH_RISK_API",
            .attack_technique => "ATTACK_TECHNIQUE",
            .unusual_api_for_account => "UNUSUAL_API_FOR_ACCOUNT",
            .unusual_asn_for_account => "UNUSUAL_ASN_FOR_ACCOUNT",
            .unusual_asn_for_user => "UNUSUAL_ASN_FOR_USER",
            .suspicious_process => "SUSPICIOUS_PROCESS",
            .malicious_domain => "MALICIOUS_DOMAIN",
            .malicious_process => "MALICIOUS_PROCESS",
            .cryptomining_ip => "CRYPTOMINING_IP",
            .cryptomining_domain => "CRYPTOMINING_DOMAIN",
            .cryptomining_process => "CRYPTOMINING_PROCESS",
            .malicious_file => "MALICIOUS_FILE",
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
