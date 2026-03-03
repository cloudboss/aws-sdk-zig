pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const ListRecommendedActionsInput = @import("list_recommended_actions.zig").ListRecommendedActionsInput;
pub const ListRecommendedActionsOutput = @import("list_recommended_actions.zig").ListRecommendedActionsOutput;
