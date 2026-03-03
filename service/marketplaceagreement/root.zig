pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const describe_agreement = @import("describe_agreement.zig");
pub const get_agreement_terms = @import("get_agreement_terms.zig");
pub const search_agreements = @import("search_agreements.zig");
