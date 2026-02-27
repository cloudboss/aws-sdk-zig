const aws = @import("aws");
const std = @import("std");

const create_monitor = @import("create_monitor.zig");
const create_probe = @import("create_probe.zig");
const delete_monitor = @import("delete_monitor.zig");
const delete_probe = @import("delete_probe.zig");
const get_monitor = @import("get_monitor.zig");
const get_probe = @import("get_probe.zig");
const list_monitors = @import("list_monitors.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_monitor = @import("update_monitor.zig");
const update_probe = @import("update_probe.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "NetworkMonitor";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a monitor between a source subnet and destination IP address. Within
    /// a monitor you'll create one or more probes that monitor network traffic
    /// between your source Amazon Web Services VPC subnets and your destination IP
    /// addresses. Each probe then aggregates and sends metrics to Amazon
    /// CloudWatch.
    ///
    /// You can also create a monitor with probes using this command. For each
    /// probe, you
    /// define the following:
    ///
    /// * `source`—The subnet IDs where the probes will be created.
    ///
    /// * `destination`— The target destination IP address for the
    /// probe.
    ///
    /// * `destinationPort`—Required only if the protocol is
    /// `TCP`.
    ///
    /// * `protocol`—The communication protocol between the source and
    /// destination. This will be either `TCP` or `ICMP`.
    ///
    /// * `packetSize`—The size of the packets. This must be a number between
    /// `56` and `8500`.
    ///
    /// * (Optional) `tags` —Key-value pairs created and assigned to the
    /// probe.
    pub fn createMonitor(self: *Self, allocator: std.mem.Allocator, input: create_monitor.CreateMonitorInput, options: create_monitor.Options) !create_monitor.CreateMonitorOutput {
        return create_monitor.execute(self, allocator, input, options);
    }

    /// Create a probe within a monitor. Once you create a probe, and it begins
    /// monitoring your
    /// network traffic, you'll incur billing charges for that probe. This action
    /// requires the
    /// `monitorName` parameter. Run `ListMonitors` to get a list of
    /// monitor names. Note the name of the `monitorName` you want to create the
    /// probe for.
    pub fn createProbe(self: *Self, allocator: std.mem.Allocator, input: create_probe.CreateProbeInput, options: create_probe.Options) !create_probe.CreateProbeOutput {
        return create_probe.execute(self, allocator, input, options);
    }

    /// Deletes a specified monitor.
    ///
    /// This action requires the `monitorName` parameter. Run
    /// `ListMonitors` to get a list of monitor names.
    pub fn deleteMonitor(self: *Self, allocator: std.mem.Allocator, input: delete_monitor.DeleteMonitorInput, options: delete_monitor.Options) !delete_monitor.DeleteMonitorOutput {
        return delete_monitor.execute(self, allocator, input, options);
    }

    /// Deletes the specified probe. Once a probe is deleted you'll no longer incur
    /// any billing
    /// fees for that probe.
    ///
    /// This action requires both the `monitorName` and `probeId`
    /// parameters. Run `ListMonitors` to get a list of monitor names. Run
    /// `GetMonitor` to get a list of probes and probe IDs. You can only delete a
    /// single probe at a time using this action.
    pub fn deleteProbe(self: *Self, allocator: std.mem.Allocator, input: delete_probe.DeleteProbeInput, options: delete_probe.Options) !delete_probe.DeleteProbeOutput {
        return delete_probe.execute(self, allocator, input, options);
    }

    /// Returns details about a specific monitor.
    ///
    /// This action requires the `monitorName` parameter. Run
    /// `ListMonitors` to get a list of monitor names.
    pub fn getMonitor(self: *Self, allocator: std.mem.Allocator, input: get_monitor.GetMonitorInput, options: get_monitor.Options) !get_monitor.GetMonitorOutput {
        return get_monitor.execute(self, allocator, input, options);
    }

    /// Returns the details about a probe. This action requires both the
    /// `monitorName` and `probeId` parameters. Run
    /// `ListMonitors` to get a list of monitor names. Run
    /// `GetMonitor` to get a list of probes and probe IDs.
    pub fn getProbe(self: *Self, allocator: std.mem.Allocator, input: get_probe.GetProbeInput, options: get_probe.Options) !get_probe.GetProbeOutput {
        return get_probe.execute(self, allocator, input, options);
    }

    /// Returns a list of all of your monitors.
    pub fn listMonitors(self: *Self, allocator: std.mem.Allocator, input: list_monitors.ListMonitorsInput, options: list_monitors.Options) !list_monitors.ListMonitorsOutput {
        return list_monitors.execute(self, allocator, input, options);
    }

    /// Lists the tags assigned to this resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds key-value pairs to a monitor or probe.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a key-value pair from a monitor or probe.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the `aggregationPeriod` for a monitor. Monitors support an
    /// `aggregationPeriod` of either `30` or `60` seconds.
    /// This action requires the `monitorName` and `probeId` parameter.
    /// Run `ListMonitors` to get a list of monitor names.
    pub fn updateMonitor(self: *Self, allocator: std.mem.Allocator, input: update_monitor.UpdateMonitorInput, options: update_monitor.Options) !update_monitor.UpdateMonitorOutput {
        return update_monitor.execute(self, allocator, input, options);
    }

    /// Updates a monitor probe. This action requires both the `monitorName` and
    /// `probeId` parameters. Run `ListMonitors` to get a list of monitor names. Run
    /// `GetMonitor` to get a list of probes and probe IDs.
    ///
    /// You can update the following para create a monitor with probes using this
    /// command. For
    /// each probe, you define the following:
    ///
    /// * `state`—The state of the probe.
    ///
    /// * `destination`— The target destination IP address for the
    /// probe.
    ///
    /// * `destinationPort`—Required only if the protocol is
    /// `TCP`.
    ///
    /// * `protocol`—The communication protocol between the source and
    /// destination. This will be either `TCP` or `ICMP`.
    ///
    /// * `packetSize`—The size of the packets. This must be a number between
    /// `56` and `8500`.
    ///
    /// * (Optional) `tags` —Key-value pairs created and assigned to the
    /// probe.
    pub fn updateProbe(self: *Self, allocator: std.mem.Allocator, input: update_probe.UpdateProbeInput, options: update_probe.Options) !update_probe.UpdateProbeOutput {
        return update_probe.execute(self, allocator, input, options);
    }

    pub fn listMonitorsPaginator(self: *Self, params: list_monitors.ListMonitorsInput) paginator.ListMonitorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
