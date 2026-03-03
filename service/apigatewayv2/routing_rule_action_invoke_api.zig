/// Represents an InvokeApi action.
pub const RoutingRuleActionInvokeApi = struct {
    api_id: []const u8,

    stage: []const u8,

    /// The strip base path setting.
    strip_base_path: ?bool = null,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .stage = "Stage",
        .strip_base_path = "StripBasePath",
    };
};
