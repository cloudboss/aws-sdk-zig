pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const GetDataAutomationStatusInput = @import("get_data_automation_status.zig").GetDataAutomationStatusInput;
pub const GetDataAutomationStatusOutput = @import("get_data_automation_status.zig").GetDataAutomationStatusOutput;
pub const InvokeDataAutomationAsyncInput = @import("invoke_data_automation_async.zig").InvokeDataAutomationAsyncInput;
pub const InvokeDataAutomationAsyncOutput = @import("invoke_data_automation_async.zig").InvokeDataAutomationAsyncOutput;
pub const InvokeDataAutomationInput = @import("invoke_data_automation.zig").InvokeDataAutomationInput;
pub const InvokeDataAutomationOutput = @import("invoke_data_automation.zig").InvokeDataAutomationOutput;
pub const ListTagsForResourceInput = @import("list_tags_for_resource.zig").ListTagsForResourceInput;
pub const ListTagsForResourceOutput = @import("list_tags_for_resource.zig").ListTagsForResourceOutput;
pub const TagResourceInput = @import("tag_resource.zig").TagResourceInput;
pub const TagResourceOutput = @import("tag_resource.zig").TagResourceOutput;
pub const UntagResourceInput = @import("untag_resource.zig").UntagResourceInput;
pub const UntagResourceOutput = @import("untag_resource.zig").UntagResourceOutput;
