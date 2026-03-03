const aws = @import("aws");
const std = @import("std");

const cancel_practice_run = @import("cancel_practice_run.zig");
const cancel_zonal_shift = @import("cancel_zonal_shift.zig");
const create_practice_run_configuration = @import("create_practice_run_configuration.zig");
const delete_practice_run_configuration = @import("delete_practice_run_configuration.zig");
const get_autoshift_observer_notification_status = @import("get_autoshift_observer_notification_status.zig");
const get_managed_resource = @import("get_managed_resource.zig");
const list_autoshifts = @import("list_autoshifts.zig");
const list_managed_resources = @import("list_managed_resources.zig");
const list_zonal_shifts = @import("list_zonal_shifts.zig");
const start_practice_run = @import("start_practice_run.zig");
const start_zonal_shift = @import("start_zonal_shift.zig");
const update_autoshift_observer_notification_status = @import("update_autoshift_observer_notification_status.zig");
const update_practice_run_configuration = @import("update_practice_run_configuration.zig");
const update_zonal_autoshift_configuration = @import("update_zonal_autoshift_configuration.zig");
const update_zonal_shift = @import("update_zonal_shift.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ARC Zonal Shift";

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

    /// Cancel an in-progress practice run zonal shift in Amazon Application
    /// Recovery Controller.
    pub fn cancelPracticeRun(self: *Self, allocator: std.mem.Allocator, input: cancel_practice_run.CancelPracticeRunInput, options: cancel_practice_run.Options) !cancel_practice_run.CancelPracticeRunOutput {
        return cancel_practice_run.execute(self, allocator, input, options);
    }

    /// Cancel a zonal shift in Amazon Application Recovery Controller. To cancel
    /// the zonal shift, specify the zonal shift ID.
    ///
    /// A zonal shift can be one that you've started for a resource in your Amazon
    /// Web Services account in an Amazon Web Services Region, or it can be a zonal
    /// shift started by a practice run with zonal autoshift.
    pub fn cancelZonalShift(self: *Self, allocator: std.mem.Allocator, input: cancel_zonal_shift.CancelZonalShiftInput, options: cancel_zonal_shift.Options) !cancel_zonal_shift.CancelZonalShiftOutput {
        return cancel_zonal_shift.execute(self, allocator, input, options);
    }

    /// A practice run configuration for zonal autoshift is required when you enable
    /// zonal autoshift. A practice run configuration includes specifications for
    /// blocked dates and blocked time windows, and for Amazon CloudWatch alarms
    /// that you create to use with practice runs. The alarms that you specify are
    /// an *outcome alarm*, to monitor application health during practice runs and,
    /// optionally, a *blocking alarm*, to block practice runs from starting.
    ///
    /// When a resource has a practice run configuration, ARC starts zonal shifts
    /// for the resource weekly, to shift traffic for practice runs. Practice runs
    /// help you to ensure that shifting away traffic from an Availability Zone
    /// during an autoshift is safe for your application.
    ///
    /// For more information, see [ Considerations when you configure zonal
    /// autoshift](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.considerations.html) in the Amazon Application Recovery Controller Developer Guide.
    pub fn createPracticeRunConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_practice_run_configuration.CreatePracticeRunConfigurationInput, options: create_practice_run_configuration.Options) !create_practice_run_configuration.CreatePracticeRunConfigurationOutput {
        return create_practice_run_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the practice run configuration for a resource. Before you can delete
    /// a practice run configuration for a resource., you must disable zonal
    /// autoshift for the resource. Practice runs must be configured for zonal
    /// autoshift to be enabled.
    pub fn deletePracticeRunConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_practice_run_configuration.DeletePracticeRunConfigurationInput, options: delete_practice_run_configuration.Options) !delete_practice_run_configuration.DeletePracticeRunConfigurationOutput {
        return delete_practice_run_configuration.execute(self, allocator, input, options);
    }

    /// Returns the status of the autoshift observer notification. Autoshift
    /// observer notifications notify you through Amazon EventBridge when there is
    /// an autoshift event for zonal autoshift. The status can be `ENABLED` or
    /// `DISABLED`. When `ENABLED`, a notification is sent when an autoshift is
    /// triggered. When `DISABLED`, notifications are not sent.
    pub fn getAutoshiftObserverNotificationStatus(self: *Self, allocator: std.mem.Allocator, input: get_autoshift_observer_notification_status.GetAutoshiftObserverNotificationStatusInput, options: get_autoshift_observer_notification_status.Options) !get_autoshift_observer_notification_status.GetAutoshiftObserverNotificationStatusOutput {
        return get_autoshift_observer_notification_status.execute(self, allocator, input, options);
    }

    /// Get information about a resource that's been registered for zonal shifts
    /// with Amazon Application Recovery Controller in this Amazon Web Services
    /// Region. Resources that are registered for zonal shifts are managed resources
    /// in ARC. You can start zonal shifts and configure zonal autoshift for managed
    /// resources.
    pub fn getManagedResource(self: *Self, allocator: std.mem.Allocator, input: get_managed_resource.GetManagedResourceInput, options: get_managed_resource.Options) !get_managed_resource.GetManagedResourceOutput {
        return get_managed_resource.execute(self, allocator, input, options);
    }

    /// Returns the autoshifts for an Amazon Web Services Region. By default, the
    /// call returns only `ACTIVE` autoshifts. Optionally, you can specify the
    /// `status` parameter to return `COMPLETED` autoshifts.
    pub fn listAutoshifts(self: *Self, allocator: std.mem.Allocator, input: list_autoshifts.ListAutoshiftsInput, options: list_autoshifts.Options) !list_autoshifts.ListAutoshiftsOutput {
        return list_autoshifts.execute(self, allocator, input, options);
    }

    /// Lists all the resources in your Amazon Web Services account in this Amazon
    /// Web Services Region that are managed for zonal shifts in Amazon Application
    /// Recovery Controller, and information about them. The information includes
    /// the zonal autoshift status for the resource, as well as the Amazon Resource
    /// Name (ARN), the Availability Zones that each resource is deployed in, and
    /// the resource name.
    pub fn listManagedResources(self: *Self, allocator: std.mem.Allocator, input: list_managed_resources.ListManagedResourcesInput, options: list_managed_resources.Options) !list_managed_resources.ListManagedResourcesOutput {
        return list_managed_resources.execute(self, allocator, input, options);
    }

    /// Lists all active and completed zonal shifts in Amazon Application Recovery
    /// Controller in your Amazon Web Services account in this Amazon Web Services
    /// Region. `ListZonalShifts` returns customer-initiated zonal shifts, as well
    /// as practice run zonal shifts that ARC started on your behalf for zonal
    /// autoshift.
    ///
    /// For more information about listing autoshifts, see
    /// [">ListAutoshifts](https://docs.aws.amazon.com/arc-zonal-shift/latest/api/API_ListAutoshifts.html).
    pub fn listZonalShifts(self: *Self, allocator: std.mem.Allocator, input: list_zonal_shifts.ListZonalShiftsInput, options: list_zonal_shifts.Options) !list_zonal_shifts.ListZonalShiftsOutput {
        return list_zonal_shifts.execute(self, allocator, input, options);
    }

    /// Start an on-demand practice run zonal shift in Amazon Application Recovery
    /// Controller. With zonal autoshift enabled, you can start an on-demand
    /// practice run to verify preparedness at any time. Amazon Web Services also
    /// runs automated practice runs about weekly when you have enabled zonal
    /// autoshift.
    ///
    /// For more information, see [ Considerations when you configure zonal
    /// autoshift](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.considerations.html) in the Amazon Application Recovery Controller Developer Guide.
    pub fn startPracticeRun(self: *Self, allocator: std.mem.Allocator, input: start_practice_run.StartPracticeRunInput, options: start_practice_run.Options) !start_practice_run.StartPracticeRunOutput {
        return start_practice_run.execute(self, allocator, input, options);
    }

    /// You start a zonal shift to temporarily move load balancer traffic away from
    /// an Availability Zone in an Amazon Web Services Region, to help your
    /// application recover immediately, for example, from a developer's bad code
    /// deployment or from an Amazon Web Services infrastructure failure in a single
    /// Availability Zone. You can start a zonal shift in ARC only for managed
    /// resources in your Amazon Web Services account in an Amazon Web Services
    /// Region. Resources are automatically registered with ARC by Amazon Web
    /// Services services.
    ///
    /// Amazon Application Recovery Controller currently supports enabling the
    /// following resources for zonal shift and zonal autoshift:
    ///
    /// * [Amazon EC2 Auto Scaling
    ///   groups](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.ec2-auto-scaling-groups.html)
    /// * [Amazon Elastic Kubernetes
    ///   Service](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.eks.html)
    /// * [Application Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.app-load-balancers.html)
    /// * [Network Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.network-load-balancers.html)
    ///
    /// When you start a zonal shift, traffic for the resource is no longer routed
    /// to the Availability Zone. The zonal shift is created immediately in ARC.
    /// However, it can take a short time, typically up to a few minutes, for
    /// existing, in-progress connections in the Availability Zone to complete.
    ///
    /// For more information, see [Zonal
    /// shift](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.html) in the Amazon Application Recovery Controller Developer Guide.
    pub fn startZonalShift(self: *Self, allocator: std.mem.Allocator, input: start_zonal_shift.StartZonalShiftInput, options: start_zonal_shift.Options) !start_zonal_shift.StartZonalShiftOutput {
        return start_zonal_shift.execute(self, allocator, input, options);
    }

    /// Update the status of autoshift observer notification. Autoshift observer
    /// notification enables you to be notified, through Amazon EventBridge, when
    /// there is an autoshift event for zonal autoshift.
    ///
    /// If the status is `ENABLED`, ARC includes all autoshift events when you use
    /// the EventBridge pattern `Autoshift In Progress`. When the status is
    /// `DISABLED`, ARC includes only autoshift events for autoshifts when one or
    /// more of your resources is included in the autoshift.
    ///
    /// For more information, see [ Notifications for practice runs and
    /// autoshifts](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.how-it-works.html#ZAShiftNotification) in the Amazon Application Recovery Controller Developer Guide.
    pub fn updateAutoshiftObserverNotificationStatus(self: *Self, allocator: std.mem.Allocator, input: update_autoshift_observer_notification_status.UpdateAutoshiftObserverNotificationStatusInput, options: update_autoshift_observer_notification_status.Options) !update_autoshift_observer_notification_status.UpdateAutoshiftObserverNotificationStatusOutput {
        return update_autoshift_observer_notification_status.execute(self, allocator, input, options);
    }

    /// Update a practice run configuration to change one or more of the following:
    /// add, change, or remove the blocking alarm; change the outcome alarm; or add,
    /// change, or remove blocking dates or time windows.
    pub fn updatePracticeRunConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_practice_run_configuration.UpdatePracticeRunConfigurationInput, options: update_practice_run_configuration.Options) !update_practice_run_configuration.UpdatePracticeRunConfigurationOutput {
        return update_practice_run_configuration.execute(self, allocator, input, options);
    }

    /// The zonal autoshift configuration for a resource includes the practice run
    /// configuration and the status for running autoshifts, zonal autoshift status.
    /// When a resource has a practice run configuration, ARC starts weekly zonal
    /// shifts for the resource, to shift traffic away from an Availability Zone.
    /// Weekly practice runs help you to make sure that your application can
    /// continue to operate normally with the loss of one Availability Zone.
    ///
    /// You can update the zonal autoshift status to enable or disable zonal
    /// autoshift. When zonal autoshift is `ENABLED`, you authorize Amazon Web
    /// Services to shift away resource traffic for an application from an
    /// Availability Zone during events, on your behalf, to help reduce time to
    /// recovery. Traffic is also shifted away for the required weekly practice
    /// runs.
    pub fn updateZonalAutoshiftConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_zonal_autoshift_configuration.UpdateZonalAutoshiftConfigurationInput, options: update_zonal_autoshift_configuration.Options) !update_zonal_autoshift_configuration.UpdateZonalAutoshiftConfigurationOutput {
        return update_zonal_autoshift_configuration.execute(self, allocator, input, options);
    }

    /// Update an active zonal shift in Amazon Application Recovery Controller in
    /// your Amazon Web Services account. You can update a zonal shift to set a new
    /// expiration, or edit or replace the comment for the zonal shift.
    pub fn updateZonalShift(self: *Self, allocator: std.mem.Allocator, input: update_zonal_shift.UpdateZonalShiftInput, options: update_zonal_shift.Options) !update_zonal_shift.UpdateZonalShiftOutput {
        return update_zonal_shift.execute(self, allocator, input, options);
    }

    pub fn listAutoshiftsPaginator(self: *Self, params: list_autoshifts.ListAutoshiftsInput) paginator.ListAutoshiftsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedResourcesPaginator(self: *Self, params: list_managed_resources.ListManagedResourcesInput) paginator.ListManagedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listZonalShiftsPaginator(self: *Self, params: list_zonal_shifts.ListZonalShiftsInput) paginator.ListZonalShiftsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
