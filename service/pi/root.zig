pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const create_performance_analysis_report = @import("create_performance_analysis_report.zig");
pub const delete_performance_analysis_report = @import("delete_performance_analysis_report.zig");
pub const describe_dimension_keys = @import("describe_dimension_keys.zig");
pub const get_dimension_key_details = @import("get_dimension_key_details.zig");
pub const get_performance_analysis_report = @import("get_performance_analysis_report.zig");
pub const get_resource_metadata = @import("get_resource_metadata.zig");
pub const get_resource_metrics = @import("get_resource_metrics.zig");
pub const list_available_resource_dimensions = @import("list_available_resource_dimensions.zig");
pub const list_available_resource_metrics = @import("list_available_resource_metrics.zig");
pub const list_performance_analysis_reports = @import("list_performance_analysis_reports.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
