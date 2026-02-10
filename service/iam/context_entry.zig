const ContextKeyTypeEnum = @import("context_key_type_enum.zig").ContextKeyTypeEnum;

/// Contains information about a condition context key. It includes the name of
/// the key and
/// specifies the value (or values, if the context key supports multiple values)
/// to use in the
/// simulation. This information is used when evaluating the `Condition`
/// elements of
/// the input policies.
///
/// This data type is used as an input parameter to
/// [SimulateCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulateCustomPolicy.html)
/// and
/// [SimulatePrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulatePrincipalPolicy.html).
pub const ContextEntry = struct {
    /// The full name of a condition context key, including the service prefix. For
    /// example,
    /// `aws:SourceIp` or `s3:VersionId`.
    context_key_name: ?[]const u8,

    /// The data type of the value (or values) specified in the `ContextKeyValues`
    /// parameter.
    context_key_type: ?ContextKeyTypeEnum,

    /// The value (or values, if the condition context key supports multiple values)
    /// to provide
    /// to the simulation when the key is referenced by a `Condition` element in an
    /// input policy.
    context_key_values: ?[]const []const u8,
};
