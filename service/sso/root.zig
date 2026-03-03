pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const GetRoleCredentialsInput = @import("get_role_credentials.zig").GetRoleCredentialsInput;
pub const GetRoleCredentialsOutput = @import("get_role_credentials.zig").GetRoleCredentialsOutput;
pub const ListAccountRolesInput = @import("list_account_roles.zig").ListAccountRolesInput;
pub const ListAccountRolesOutput = @import("list_account_roles.zig").ListAccountRolesOutput;
pub const ListAccountsInput = @import("list_accounts.zig").ListAccountsInput;
pub const ListAccountsOutput = @import("list_accounts.zig").ListAccountsOutput;
pub const LogoutInput = @import("logout.zig").LogoutInput;
