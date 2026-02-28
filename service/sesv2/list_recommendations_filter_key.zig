/// The `ListRecommendations` filter type. This can be one of the following:
///
/// * `TYPE` – The recommendation type, with values like `DKIM`,
/// `SPF`, `DMARC`, `BIMI`, or `COMPLAINT`.
///
/// * `IMPACT` – The recommendation impact, with values like
/// `HIGH` or `LOW`.
///
/// * `STATUS` – The recommendation status, with values like
/// `OPEN` or `FIXED`.
///
/// * `RESOURCE_ARN` – The resource affected by the recommendation,
/// with values like `arn:aws:ses:us-east-1:123456789012:identity/example.com`.
pub const ListRecommendationsFilterKey = enum {
    @"type",
    impact,
    status,
    resource_arn,

    pub const json_field_names = .{
        .@"type" = "TYPE",
        .impact = "IMPACT",
        .status = "STATUS",
        .resource_arn = "RESOURCE_ARN",
    };
};
