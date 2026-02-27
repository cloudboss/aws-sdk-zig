pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_slack_channel_configuration = @import("create_slack_channel_configuration.zig");
pub const delete_account_alias = @import("delete_account_alias.zig");
pub const delete_slack_channel_configuration = @import("delete_slack_channel_configuration.zig");
pub const delete_slack_workspace_configuration = @import("delete_slack_workspace_configuration.zig");
pub const get_account_alias = @import("get_account_alias.zig");
pub const list_slack_channel_configurations = @import("list_slack_channel_configurations.zig");
pub const list_slack_workspace_configurations = @import("list_slack_workspace_configurations.zig");
pub const put_account_alias = @import("put_account_alias.zig");
pub const register_slack_workspace_for_organization = @import("register_slack_workspace_for_organization.zig");
pub const update_slack_channel_configuration = @import("update_slack_channel_configuration.zig");
