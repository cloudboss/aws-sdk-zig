pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const get_preferences = @import("get_preferences.zig");
pub const get_recommendation = @import("get_recommendation.zig");
pub const list_efficiency_metrics = @import("list_efficiency_metrics.zig");
pub const list_enrollment_statuses = @import("list_enrollment_statuses.zig");
pub const list_recommendation_summaries = @import("list_recommendation_summaries.zig");
pub const list_recommendations = @import("list_recommendations.zig");
pub const update_enrollment_status = @import("update_enrollment_status.zig");
pub const update_preferences = @import("update_preferences.zig");
