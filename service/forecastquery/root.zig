pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const query_forecast = @import("query_forecast.zig");
pub const query_what_if_forecast = @import("query_what_if_forecast.zig");
