pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const get_data_automation_status = @import("get_data_automation_status.zig");
pub const invoke_data_automation = @import("invoke_data_automation.zig");
pub const invoke_data_automation_async = @import("invoke_data_automation_async.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
