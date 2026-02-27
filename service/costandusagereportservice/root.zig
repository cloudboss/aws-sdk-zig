pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const delete_report_definition = @import("delete_report_definition.zig");
pub const describe_report_definitions = @import("describe_report_definitions.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const modify_report_definition = @import("modify_report_definition.zig");
pub const put_report_definition = @import("put_report_definition.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
