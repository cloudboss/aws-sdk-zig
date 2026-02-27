/// A system asset that's evaluated in an Audit Manager assessment.
pub const Resource = struct {
    /// The Amazon Resource Name (ARN) for the resource.
    arn: ?[]const u8,

    /// The evaluation status for a resource that was assessed when collecting
    /// compliance check
    /// evidence.
    ///
    /// * Audit Manager classes the resource as non-compliant if Security Hub
    ///   reports a
    /// *Fail* result, or if Config reports a
    /// *Non-compliant* result.
    ///
    /// * Audit Manager classes the resource as compliant if Security Hub reports a
    /// *Pass* result, or if Config reports a
    /// *Compliant* result.
    ///
    /// * If a compliance check isn't available or applicable, then no compliance
    ///   evaluation can be made
    /// for that resource. This is the case if a resource assessment uses Config or
    /// Security Hub as the underlying data source type, but those services
    /// aren't enabled. This is also the case if the resource assessment uses an
    /// underlying
    /// data source type that doesn't support compliance checks (such as manual
    /// evidence,
    /// Amazon Web Services API calls, or CloudTrail).
    compliance_check: ?[]const u8,

    /// The value of the resource.
    value: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .compliance_check = "complianceCheck",
        .value = "value",
    };
};
