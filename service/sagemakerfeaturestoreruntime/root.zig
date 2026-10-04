pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const BatchGetRecordInput = @import("batch_get_record.zig").BatchGetRecordInput;
pub const BatchGetRecordOutput = @import("batch_get_record.zig").BatchGetRecordOutput;
pub const BatchWriteRecordInput = @import("batch_write_record.zig").BatchWriteRecordInput;
pub const BatchWriteRecordOutput = @import("batch_write_record.zig").BatchWriteRecordOutput;
pub const DeleteRecordInput = @import("delete_record.zig").DeleteRecordInput;
pub const GetRecordInput = @import("get_record.zig").GetRecordInput;
pub const GetRecordOutput = @import("get_record.zig").GetRecordOutput;
pub const ListRecordsInput = @import("list_records.zig").ListRecordsInput;
pub const ListRecordsOutput = @import("list_records.zig").ListRecordsOutput;
pub const PutRecordInput = @import("put_record.zig").PutRecordInput;
pub const UpdateRecordInput = @import("update_record.zig").UpdateRecordInput;
