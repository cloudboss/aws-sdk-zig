const aws = @import("aws");
const std = @import("std");

const create_schedule = @import("create_schedule.zig");
const create_schedule_group = @import("create_schedule_group.zig");
const delete_schedule = @import("delete_schedule.zig");
const delete_schedule_group = @import("delete_schedule_group.zig");
const get_schedule = @import("get_schedule.zig");
const get_schedule_group = @import("get_schedule_group.zig");
const list_schedule_groups = @import("list_schedule_groups.zig");
const list_schedules = @import("list_schedules.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_schedule = @import("update_schedule.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Scheduler";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates the specified schedule.
    pub fn createSchedule(self: *Self, allocator: std.mem.Allocator, input: create_schedule.CreateScheduleInput, options: CallOptions) !create_schedule.CreateScheduleOutput {
        return create_schedule.execute(self, allocator, input, options);
    }

    /// Creates the specified schedule group.
    pub fn createScheduleGroup(self: *Self, allocator: std.mem.Allocator, input: create_schedule_group.CreateScheduleGroupInput, options: CallOptions) !create_schedule_group.CreateScheduleGroupOutput {
        return create_schedule_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified schedule.
    pub fn deleteSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_schedule.DeleteScheduleInput, options: CallOptions) !delete_schedule.DeleteScheduleOutput {
        return delete_schedule.execute(self, allocator, input, options);
    }

    /// Deletes the specified schedule group. Deleting a schedule group results in
    /// EventBridge Scheduler deleting all schedules associated with the group.
    /// When you delete a group, it remains in a `DELETING` state until all of its
    /// associated schedules are deleted.
    /// Schedules associated with the group that are set to run while the schedule
    /// group is in the process of being deleted might continue to invoke their
    /// targets
    /// until the schedule group and its associated schedules are deleted.
    ///
    /// This operation is eventually consistent.
    pub fn deleteScheduleGroup(self: *Self, allocator: std.mem.Allocator, input: delete_schedule_group.DeleteScheduleGroupInput, options: CallOptions) !delete_schedule_group.DeleteScheduleGroupOutput {
        return delete_schedule_group.execute(self, allocator, input, options);
    }

    /// Retrieves the specified schedule.
    pub fn getSchedule(self: *Self, allocator: std.mem.Allocator, input: get_schedule.GetScheduleInput, options: CallOptions) !get_schedule.GetScheduleOutput {
        return get_schedule.execute(self, allocator, input, options);
    }

    /// Retrieves the specified schedule group.
    pub fn getScheduleGroup(self: *Self, allocator: std.mem.Allocator, input: get_schedule_group.GetScheduleGroupInput, options: CallOptions) !get_schedule_group.GetScheduleGroupOutput {
        return get_schedule_group.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of your schedule groups.
    pub fn listScheduleGroups(self: *Self, allocator: std.mem.Allocator, input: list_schedule_groups.ListScheduleGroupsInput, options: CallOptions) !list_schedule_groups.ListScheduleGroupsOutput {
        return list_schedule_groups.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of your EventBridge Scheduler schedules.
    pub fn listSchedules(self: *Self, allocator: std.mem.Allocator, input: list_schedules.ListSchedulesInput, options: CallOptions) !list_schedules.ListSchedulesOutput {
        return list_schedules.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with the Scheduler resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified EventBridge
    /// Scheduler resource. You can only assign tags to schedule groups.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified EventBridge Scheduler schedule
    /// group.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified schedule. When you call `UpdateSchedule`, EventBridge
    /// Scheduler uses all values, including empty values, specified in the request
    /// and
    /// overrides the existing schedule. This is by design. This means that if you
    /// do not set an optional field in your request, that field will be set to
    /// its system-default value after the update.
    ///
    /// Before calling this operation, we recommend that you call the `GetSchedule`
    /// API operation and make a note of all optional parameters
    /// for your `UpdateSchedule` call.
    pub fn updateSchedule(self: *Self, allocator: std.mem.Allocator, input: update_schedule.UpdateScheduleInput, options: CallOptions) !update_schedule.UpdateScheduleOutput {
        return update_schedule.execute(self, allocator, input, options);
    }

    pub fn listScheduleGroupsPaginator(self: *Self, params: list_schedule_groups.ListScheduleGroupsInput) paginator.ListScheduleGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchedulesPaginator(self: *Self, params: list_schedules.ListSchedulesInput) paginator.ListSchedulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
