pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const search = @import("search.zig");
pub const suggest = @import("suggest.zig");
pub const upload_documents = @import("upload_documents.zig");
