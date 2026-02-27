pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const get_action_recommendations = @import("get_action_recommendations.zig");
pub const get_personalized_ranking = @import("get_personalized_ranking.zig");
pub const get_recommendations = @import("get_recommendations.zig");
