/// Details tactics, techniques, and procedures (TTPs) used in a potential
/// security event. Tactics are based on [MITRE ATT&CK Matrix for
/// Enterprise](https://attack.mitre.org/matrices/enterprise/).
pub const TTPsObservedDetail = struct {
    /// The total number of failed API requests.
    api_failure_count: i64 = 0,

    /// The name of the API where the tactics, techniques, and procedure (TTP) was
    /// observed.
    api_name: ?[]const u8 = null,

    /// The total number of successful API requests.
    api_success_count: i64 = 0,

    /// The IP address where the tactics, techniques, and procedure (TTP) was
    /// observed.
    ip_address: ?[]const u8 = null,

    /// The procedure used, identified by the investigation.
    procedure: ?[]const u8 = null,

    /// The tactic used, identified by the investigation.
    tactic: ?[]const u8 = null,

    /// The technique used, identified by the investigation.
    technique: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_failure_count = "APIFailureCount",
        .api_name = "APIName",
        .api_success_count = "APISuccessCount",
        .ip_address = "IpAddress",
        .procedure = "Procedure",
        .tactic = "Tactic",
        .technique = "Technique",
    };
};
