pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const describe_report_creation = @import("describe_report_creation.zig");
pub const get_compliance_summary = @import("get_compliance_summary.zig");
pub const get_resources = @import("get_resources.zig");
pub const get_tag_keys = @import("get_tag_keys.zig");
pub const get_tag_values = @import("get_tag_values.zig");
pub const list_required_tags = @import("list_required_tags.zig");
pub const start_report_creation = @import("start_report_creation.zig");
pub const tag_resources = @import("tag_resources.zig");
pub const untag_resources = @import("untag_resources.zig");
