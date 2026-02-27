pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const get_search_job = @import("get_search_job.zig");
pub const get_search_result_export_job = @import("get_search_result_export_job.zig");
pub const list_search_job_backups = @import("list_search_job_backups.zig");
pub const list_search_job_results = @import("list_search_job_results.zig");
pub const list_search_jobs = @import("list_search_jobs.zig");
pub const list_search_result_export_jobs = @import("list_search_result_export_jobs.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const start_search_job = @import("start_search_job.zig");
pub const start_search_result_export_job = @import("start_search_result_export_job.zig");
pub const stop_search_job = @import("stop_search_job.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
