pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const BatchGetRecordInput = @import("batch_get_record.zig").BatchGetRecordInput;
pub const BatchGetRecordOutput = @import("batch_get_record.zig").BatchGetRecordOutput;
pub const DeleteRecordInput = @import("delete_record.zig").DeleteRecordInput;
pub const GetRecordInput = @import("get_record.zig").GetRecordInput;
pub const GetRecordOutput = @import("get_record.zig").GetRecordOutput;
pub const PutRecordInput = @import("put_record.zig").PutRecordInput;
