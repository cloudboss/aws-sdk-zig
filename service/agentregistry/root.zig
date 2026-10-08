pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const BatchGetDiscoverableRegistryRecordInput = @import("batch_get_discoverable_registry_record.zig").BatchGetDiscoverableRegistryRecordInput;
pub const BatchGetDiscoverableRegistryRecordOutput = @import("batch_get_discoverable_registry_record.zig").BatchGetDiscoverableRegistryRecordOutput;
pub const ListDiscoverableRegistryRecordsInput = @import("list_discoverable_registry_records.zig").ListDiscoverableRegistryRecordsInput;
pub const ListDiscoverableRegistryRecordsOutput = @import("list_discoverable_registry_records.zig").ListDiscoverableRegistryRecordsOutput;
pub const SearchDiscoverableRegistryRecordsInput = @import("search_discoverable_registry_records.zig").SearchDiscoverableRegistryRecordsInput;
pub const SearchDiscoverableRegistryRecordsOutput = @import("search_discoverable_registry_records.zig").SearchDiscoverableRegistryRecordsOutput;
