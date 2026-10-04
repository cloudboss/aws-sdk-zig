const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;

/// The configuration for a DNS threat protection rule type within the rule type
/// framework.
pub const DnsThreatProtectionRuleTypeConfig = struct {
    /// The confidence threshold for DNS Firewall Advanced. You must provide this
    /// value when you create or update a DNS Firewall Advanced rule. The confidence
    /// level values mean:
    ///
    /// * `LOW`: Provides the highest detection rate for threats, but also increases
    ///   false positives.
    ///
    /// * `MEDIUM`: Provides a balance between detecting threats and false
    ///   positives.
    ///
    /// * `HIGH`: Detects only the most well corroborated threats with a low rate of
    ///   false positives.
    confidence_threshold: ConfidenceThreshold,

    /// The type of DNS threat protection. Valid values are:
    ///
    /// * `DGA`: Domain generation algorithms detection. DGAs are used by attackers
    ///   to generate a large number of domains to launch malware attacks.
    ///
    /// * `DNS_TUNNELING`: DNS tunneling detection. DNS tunneling is used by
    ///   attackers to exfiltrate data from the client by using the DNS tunnel
    ///   without making a network connection to the client.
    ///
    /// * `DICTIONARY_DGA`: Dictionary-based domain generation algorithms detection.
    ///   Dictionary DGAs use wordlists to generate domains that appear more
    ///   legitimate, making them harder to detect than traditional DGAs.
    value: []const u8,

    pub const json_field_names = .{
        .confidence_threshold = "ConfidenceThreshold",
        .value = "Value",
    };
};
