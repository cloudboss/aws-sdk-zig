const CisaData = @import("cisa_data.zig").CisaData;
const Evidence = @import("evidence.zig").Evidence;
const ExploitObserved = @import("exploit_observed.zig").ExploitObserved;

/// Details of the vulnerability identified in a finding.
pub const FindingDetail = struct {
    /// The Cybersecurity and Infrastructure Security Agency (CISA) details for a
    /// specific
    /// vulnerability.
    cisa_data: ?CisaData,

    /// The Common Weakness Enumerations (CWEs) associated with the vulnerability.
    cwes: ?[]const []const u8,

    /// The Exploit Prediction Scoring System (EPSS) score of the vulnerability.
    epss_score: ?f64,

    /// Information on the evidence of the vulnerability.
    evidences: ?[]const Evidence,

    /// Contains information on when this exploit was observed.
    exploit_observed: ?ExploitObserved,

    /// The finding ARN that the vulnerability details are associated with.
    finding_arn: ?[]const u8,

    /// The reference URLs for the vulnerability data.
    reference_urls: ?[]const []const u8,

    /// The risk score of the vulnerability.
    risk_score: ?i32,

    /// The known malware tools or kits that can exploit the vulnerability.
    tools: ?[]const []const u8,

    /// The MITRE adversary tactics, techniques, or procedures (TTPs) associated
    /// with the
    /// vulnerability.
    ttps: ?[]const []const u8,

    pub const json_field_names = .{
        .cisa_data = "cisaData",
        .cwes = "cwes",
        .epss_score = "epssScore",
        .evidences = "evidences",
        .exploit_observed = "exploitObserved",
        .finding_arn = "findingArn",
        .reference_urls = "referenceUrls",
        .risk_score = "riskScore",
        .tools = "tools",
        .ttps = "ttps",
    };
};
