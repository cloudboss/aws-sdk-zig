const PromptRouterTargetModel = @import("prompt_router_target_model.zig").PromptRouterTargetModel;
const RoutingCriteria = @import("routing_criteria.zig").RoutingCriteria;
const PromptRouterStatus = @import("prompt_router_status.zig").PromptRouterStatus;
const PromptRouterType = @import("prompt_router_type.zig").PromptRouterType;

/// Details about a prompt router.
pub const PromptRouterSummary = struct {
    /// When the router was created.
    created_at: ?i64 = null,

    /// The router's description.
    description: ?[]const u8 = null,

    /// The router's fallback model.
    fallback_model: PromptRouterTargetModel,

    /// The router's models.
    models: []const PromptRouterTargetModel,

    /// The router's ARN.
    prompt_router_arn: []const u8,

    /// The router's name.
    prompt_router_name: []const u8,

    /// The router's routing criteria.
    routing_criteria: RoutingCriteria,

    /// The router's status.
    status: PromptRouterStatus,

    /// The summary's type.
    @"type": PromptRouterType,

    /// When the router was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .fallback_model = "fallbackModel",
        .models = "models",
        .prompt_router_arn = "promptRouterArn",
        .prompt_router_name = "promptRouterName",
        .routing_criteria = "routingCriteria",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
