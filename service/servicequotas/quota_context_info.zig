const QuotaContextScope = @import("quota_context_scope.zig").QuotaContextScope;

/// A structure that describes the context for a resource-level quota. For
/// resource-level quotas, such as `Instances per OpenSearch Service Domain`,
/// you can apply the quota value at the resource-level for each OpenSearch
/// Service Domain in your Amazon Web Services account. Together the attributes
/// of this structure help you understand how the quota is implemented by Amazon
/// Web Services and how you can manage it. For quotas such as `Amazon
/// OpenSearch Service Domains` which can be managed at the account-level for
/// each Amazon Web Services Region, the `QuotaContext` field is absent. See the
/// attribute descriptions below to further understand how to use them.
pub const QuotaContextInfo = struct {
    /// Specifies the resource, or resources, to which the quota applies. The value
    /// for this field is either an Amazon Resource Name (ARN) or *. If the value is
    /// an ARN, the quota value applies to that resource. If the value is *, then
    /// the quota value applies to all resources listed in the `ContextScopeType`
    /// field. The quota value applies to all resources for which you haven’t
    /// previously applied a quota value, and any new resources you create in your
    /// Amazon Web Services account.
    context_id: ?[]const u8,

    /// Specifies the scope to which the quota value is applied. If the scope is
    /// `RESOURCE`, the quota value is applied to each resource in the Amazon Web
    /// Services account. If the scope is `ACCOUNT`, the quota value is applied to
    /// the Amazon Web Services account.
    context_scope: ?QuotaContextScope,

    /// Specifies the resource type to which the quota can be applied.
    context_scope_type: ?[]const u8,

    pub const json_field_names = .{
        .context_id = "ContextId",
        .context_scope = "ContextScope",
        .context_scope_type = "ContextScopeType",
    };
};
