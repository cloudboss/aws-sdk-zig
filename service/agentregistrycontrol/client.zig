const aws = @import("aws");
const std = @import("std");

const create_registry = @import("create_registry.zig");
const create_registry_record = @import("create_registry_record.zig");
const delete_registry = @import("delete_registry.zig");
const delete_registry_record = @import("delete_registry_record.zig");
const get_registry = @import("get_registry.zig");
const get_registry_record = @import("get_registry_record.zig");
const list_registries = @import("list_registries.zig");
const list_registry_records = @import("list_registry_records.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const submit_registry_record_for_approval = @import("submit_registry_record_for_approval.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_registry = @import("update_registry.zig");
const update_registry_record = @import("update_registry_record.zig");
const update_registry_record_status = @import("update_registry_record_status.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Agent Registry Control";

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

    /// Creates a new registry, a catalog that organizes registry records and
    /// defines their discovery authorization and record approval behavior. Creation
    /// is asynchronous: the registry begins in the CREATING status and becomes
    /// usable once it reaches READY.
    pub fn createRegistry(self: *Self, allocator: std.mem.Allocator, input: create_registry.CreateRegistryInput, options: CallOptions) !create_registry.CreateRegistryOutput {
        return create_registry.execute(self, allocator, input, options);
    }

    /// Creates a registry record within a registry. A registry record describes a
    /// discoverable resource, such as an MCP server, an agent, an agent skill, or a
    /// custom resource. Creation is asynchronous: the record is returned with the
    /// CREATING status while it is processed.
    pub fn createRegistryRecord(self: *Self, allocator: std.mem.Allocator, input: create_registry_record.CreateRegistryRecordInput, options: CallOptions) !create_registry_record.CreateRegistryRecordOutput {
        return create_registry_record.execute(self, allocator, input, options);
    }

    /// Deletes a registry. Deletion is asynchronous: the registry transitions to
    /// the DELETING status and is removed along with its registry records.
    pub fn deleteRegistry(self: *Self, allocator: std.mem.Allocator, input: delete_registry.DeleteRegistryInput, options: CallOptions) !delete_registry.DeleteRegistryOutput {
        return delete_registry.execute(self, allocator, input, options);
    }

    /// Deletes a registry record
    pub fn deleteRegistryRecord(self: *Self, allocator: std.mem.Allocator, input: delete_registry_record.DeleteRegistryRecordInput, options: CallOptions) !delete_registry_record.DeleteRegistryRecordOutput {
        return delete_registry_record.execute(self, allocator, input, options);
    }

    /// Gets a registry by identifier (ARN or ID)
    pub fn getRegistry(self: *Self, allocator: std.mem.Allocator, input: get_registry.GetRegistryInput, options: CallOptions) !get_registry.GetRegistryOutput {
        return get_registry.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a registry record
    pub fn getRegistryRecord(self: *Self, allocator: std.mem.Allocator, input: get_registry_record.GetRegistryRecordInput, options: CallOptions) !get_registry_record.GetRegistryRecordOutput {
        return get_registry_record.execute(self, allocator, input, options);
    }

    /// Lists the registries in the caller's account and Region, with optional
    /// filtering by status and discovery authorizer type
    pub fn listRegistries(self: *Self, allocator: std.mem.Allocator, input: list_registries.ListRegistriesInput, options: CallOptions) !list_registries.ListRegistriesOutput {
        return list_registries.execute(self, allocator, input, options);
    }

    /// Lists the registry records within a registry, with optional filtering by
    /// name, status, and record type
    pub fn listRegistryRecords(self: *Self, allocator: std.mem.Allocator, input: list_registry_records.ListRegistryRecordsInput, options: CallOptions) !list_registry_records.ListRegistryRecordsOutput {
        return list_registry_records.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with the specified Amazon Web Services Agent
    /// Registry resource. Returns the current tag key-value pairs on the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Submits a DRAFT registry record for approval, moving it into the registry's
    /// approval workflow. Depending on the registry's approval configuration, the
    /// record is either auto-approved or set to PENDING_APPROVAL for a curator to
    /// approve or reject.
    pub fn submitRegistryRecordForApproval(self: *Self, allocator: std.mem.Allocator, input: submit_registry_record_for_approval.SubmitRegistryRecordForApprovalInput, options: CallOptions) !submit_registry_record_for_approval.SubmitRegistryRecordForApprovalOutput {
        return submit_registry_record_for_approval.execute(self, allocator, input, options);
    }

    /// Adds or overwrites one or more tags for the specified Amazon Web Services
    /// Agent Registry resource. Tags are key-value pairs that you can use to
    /// categorize and manage Amazon Web Services resources. If a tag with the same
    /// key already exists on the resource, the service replaces its value with the
    /// value you specify.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified Amazon Web Services Agent
    /// Registry resource. The operation removes only the tags whose keys you
    /// supply; other tags on the resource remain unchanged.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing registry. This operation uses PATCH semantics: specify
    /// only the fields you want to change, and omit the rest to leave them
    /// unchanged. Updates are applied asynchronously and the registry transitions
    /// to the UPDATING status while they are processed.
    pub fn updateRegistry(self: *Self, allocator: std.mem.Allocator, input: update_registry.UpdateRegistryInput, options: CallOptions) !update_registry.UpdateRegistryOutput {
        return update_registry.execute(self, allocator, input, options);
    }

    /// Updates a registry record. The update is asynchronous: the record is
    /// returned with the UPDATING status while it is processed. Fields that use
    /// update wrappers follow PATCH semantics: omit the field to leave it
    /// unchanged.
    pub fn updateRegistryRecord(self: *Self, allocator: std.mem.Allocator, input: update_registry_record.UpdateRegistryRecordInput, options: CallOptions) !update_registry_record.UpdateRegistryRecordOutput {
        return update_registry_record.execute(self, allocator, input, options);
    }

    /// Updates the status of a registry record as part of the registry's curation
    /// workflow, for example to approve or reject a record that is pending
    /// approval, or to deprecate an approved record so that it is no longer
    /// discoverable
    pub fn updateRegistryRecordStatus(self: *Self, allocator: std.mem.Allocator, input: update_registry_record_status.UpdateRegistryRecordStatusInput, options: CallOptions) !update_registry_record_status.UpdateRegistryRecordStatusOutput {
        return update_registry_record_status.execute(self, allocator, input, options);
    }

    pub fn listRegistriesPaginator(self: *Self, params: list_registries.ListRegistriesInput) paginator.ListRegistriesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRegistryRecordsPaginator(self: *Self, params: list_registry_records.ListRegistryRecordsInput) paginator.ListRegistryRecordsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilRegistryReady(self: *Self, params: get_registry.GetRegistryInput) aws.waiter.WaiterError!void {
        var w = waiters.RegistryReadyWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilRegistryRecordApproved(self: *Self, params: get_registry_record.GetRegistryRecordInput) aws.waiter.WaiterError!void {
        var w = waiters.RegistryRecordApprovedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
