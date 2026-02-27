pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const deregister_subscription_provider = @import("deregister_subscription_provider.zig");
pub const get_registered_subscription_provider = @import("get_registered_subscription_provider.zig");
pub const get_service_settings = @import("get_service_settings.zig");
pub const list_linux_subscription_instances = @import("list_linux_subscription_instances.zig");
pub const list_linux_subscriptions = @import("list_linux_subscriptions.zig");
pub const list_registered_subscription_providers = @import("list_registered_subscription_providers.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const register_subscription_provider = @import("register_subscription_provider.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_service_settings = @import("update_service_settings.zig");
