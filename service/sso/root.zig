pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const get_role_credentials = @import("get_role_credentials.zig");
pub const list_account_roles = @import("list_account_roles.zig");
pub const list_accounts = @import("list_accounts.zig");
pub const logout = @import("logout.zig");
