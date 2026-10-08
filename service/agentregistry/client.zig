const aws = @import("aws");
const std = @import("std");

const batch_get_discoverable_registry_record = @import("batch_get_discoverable_registry_record.zig");
const list_discoverable_registry_records = @import("list_discoverable_registry_records.zig");
const search_discoverable_registry_records = @import("search_discoverable_registry_records.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Agent Registry";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Retrieves multiple discoverable registry records by ID from a single
    /// registry. Records that cannot be retrieved are reported individually in the
    /// `errors` list rather than failing the entire request.
    pub fn batchGetDiscoverableRegistryRecord(self: *Self, allocator: std.mem.Allocator, input: batch_get_discoverable_registry_record.BatchGetDiscoverableRegistryRecordInput, options: CallOptions) !batch_get_discoverable_registry_record.BatchGetDiscoverableRegistryRecordOutput {
        return batch_get_discoverable_registry_record.execute(self, allocator, input, options);
    }

    /// Lists the discoverable registry records in a registry. You can optionally
    /// filter and paginate the results.
    pub fn listDiscoverableRegistryRecords(self: *Self, allocator: std.mem.Allocator, input: list_discoverable_registry_records.ListDiscoverableRegistryRecordsInput, options: CallOptions) !list_discoverable_registry_records.ListDiscoverableRegistryRecordsOutput {
        return list_discoverable_registry_records.execute(self, allocator, input, options);
    }

    /// Searches the discoverable registry records in a registry using a natural
    /// language query. Returns metadata for the matching records ordered by
    /// relevance.
    pub fn searchDiscoverableRegistryRecords(self: *Self, allocator: std.mem.Allocator, input: search_discoverable_registry_records.SearchDiscoverableRegistryRecordsInput, options: CallOptions) !search_discoverable_registry_records.SearchDiscoverableRegistryRecordsOutput {
        return search_discoverable_registry_records.execute(self, allocator, input, options);
    }

    pub fn listDiscoverableRegistryRecordsPaginator(self: *Self, params: list_discoverable_registry_records.ListDiscoverableRegistryRecordsInput) paginator.ListDiscoverableRegistryRecordsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
