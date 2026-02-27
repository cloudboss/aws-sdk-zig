pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const autocomplete = @import("autocomplete.zig");
pub const geocode = @import("geocode.zig");
pub const get_place = @import("get_place.zig");
pub const reverse_geocode = @import("reverse_geocode.zig");
pub const search_nearby = @import("search_nearby.zig");
pub const search_text = @import("search_text.zig");
pub const suggest = @import("suggest.zig");
