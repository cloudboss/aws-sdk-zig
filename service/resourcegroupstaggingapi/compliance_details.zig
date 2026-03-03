/// Information that shows whether a resource is compliant with the effective
/// tag policy,
/// including details on any noncompliant tag keys.
pub const ComplianceDetails = struct {
    /// Whether a resource is compliant with the effective tag policy.
    compliance_status: ?bool = null,

    /// These are keys defined in the effective policy that are on the resource with
    /// either
    /// incorrect case treatment or noncompliant values.
    keys_with_noncompliant_values: ?[]const []const u8 = null,

    /// These tag keys on the resource are noncompliant with the effective tag
    /// policy.
    noncompliant_keys: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .compliance_status = "ComplianceStatus",
        .keys_with_noncompliant_values = "KeysWithNoncompliantValues",
        .noncompliant_keys = "NoncompliantKeys",
    };
};
