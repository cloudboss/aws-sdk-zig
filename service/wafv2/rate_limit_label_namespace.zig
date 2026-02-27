/// Specifies a label namespace to use as an aggregate key for a rate-based
/// rule. Each distinct fully qualified label name that has the specified label
/// namespace contributes to the aggregation instance. If you use just one label
/// namespace as your custom key, then each label name fully defines an
/// aggregation instance.
///
/// This uses only labels that have been added to the request by rules that are
/// evaluated before this rate-based rule in the web ACL.
///
/// For information about label namespaces and names, see
/// [Label syntax and naming
/// requirements](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-label-requirements.html) in the *WAF Developer Guide*.
pub const RateLimitLabelNamespace = struct {
    /// The namespace to use for aggregation.
    namespace: []const u8,

    pub const json_field_names = .{
        .namespace = "Namespace",
    };
};
