const aws = @import("aws");
const std = @import("std");

const create_landing_zone = @import("create_landing_zone.zig");
const delete_landing_zone = @import("delete_landing_zone.zig");
const disable_baseline = @import("disable_baseline.zig");
const disable_control = @import("disable_control.zig");
const enable_baseline = @import("enable_baseline.zig");
const enable_control = @import("enable_control.zig");
const get_baseline = @import("get_baseline.zig");
const get_baseline_operation = @import("get_baseline_operation.zig");
const get_control_operation = @import("get_control_operation.zig");
const get_enabled_baseline = @import("get_enabled_baseline.zig");
const get_enabled_control = @import("get_enabled_control.zig");
const get_landing_zone = @import("get_landing_zone.zig");
const get_landing_zone_operation = @import("get_landing_zone_operation.zig");
const list_baselines = @import("list_baselines.zig");
const list_control_operations = @import("list_control_operations.zig");
const list_enabled_baselines = @import("list_enabled_baselines.zig");
const list_enabled_controls = @import("list_enabled_controls.zig");
const list_landing_zone_operations = @import("list_landing_zone_operations.zig");
const list_landing_zones = @import("list_landing_zones.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reset_enabled_baseline = @import("reset_enabled_baseline.zig");
const reset_enabled_control = @import("reset_enabled_control.zig");
const reset_landing_zone = @import("reset_landing_zone.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_enabled_baseline = @import("update_enabled_baseline.zig");
const update_enabled_control = @import("update_enabled_control.zig");
const update_landing_zone = @import("update_landing_zone.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ControlTower";

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

    /// Creates a new landing zone. This API call starts an asynchronous operation
    /// that creates and configures a landing zone, based on the parameters
    /// specified in the manifest JSON file.
    pub fn createLandingZone(self: *Self, allocator: std.mem.Allocator, input: create_landing_zone.CreateLandingZoneInput, options: CallOptions) !create_landing_zone.CreateLandingZoneOutput {
        return create_landing_zone.execute(self, allocator, input, options);
    }

    /// Decommissions a landing zone. This API call starts an asynchronous operation
    /// that deletes Amazon Web Services Control Tower resources deployed in
    /// accounts managed by Amazon Web Services Control Tower.
    ///
    /// Decommissioning a landing zone is a process with significant consequences,
    /// and it cannot be undone. We strongly recommend that you perform this
    /// decommissioning process only if you intend to stop using your landing zone.
    pub fn deleteLandingZone(self: *Self, allocator: std.mem.Allocator, input: delete_landing_zone.DeleteLandingZoneInput, options: CallOptions) !delete_landing_zone.DeleteLandingZoneOutput {
        return delete_landing_zone.execute(self, allocator, input, options);
    }

    /// Disable an `EnabledBaseline` resource on the specified Target. This API
    /// starts an asynchronous operation to remove all resources deployed as part of
    /// the baseline enablement. The resource will vary depending on the enabled
    /// baseline. For usage examples, see [ *the Amazon Web Services Control Tower
    /// User Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn disableBaseline(self: *Self, allocator: std.mem.Allocator, input: disable_baseline.DisableBaselineInput, options: CallOptions) !disable_baseline.DisableBaselineOutput {
        return disable_baseline.execute(self, allocator, input, options);
    }

    /// This API call turns off a control. It starts an asynchronous operation that
    /// deletes Amazon Web Services resources on the specified organizational unit
    /// and the accounts it contains. The resources will vary according to the
    /// control that you specify. For usage examples, see the [ *Controls Reference
    /// Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn disableControl(self: *Self, allocator: std.mem.Allocator, input: disable_control.DisableControlInput, options: CallOptions) !disable_control.DisableControlOutput {
        return disable_control.execute(self, allocator, input, options);
    }

    /// Enable (apply) a `Baseline` to a Target. This API starts an asynchronous
    /// operation to deploy resources specified by the `Baseline` to the specified
    /// Target. For usage examples, see [ *the Amazon Web Services Control Tower
    /// User Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn enableBaseline(self: *Self, allocator: std.mem.Allocator, input: enable_baseline.EnableBaselineInput, options: CallOptions) !enable_baseline.EnableBaselineOutput {
        return enable_baseline.execute(self, allocator, input, options);
    }

    /// This API call activates a control. It starts an asynchronous operation that
    /// creates Amazon Web Services resources on the specified organizational unit
    /// and the accounts it contains. The resources created will vary according to
    /// the control that you specify. For usage examples, see the [ *Controls
    /// Reference Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn enableControl(self: *Self, allocator: std.mem.Allocator, input: enable_control.EnableControlInput, options: CallOptions) !enable_control.EnableControlOutput {
        return enable_control.execute(self, allocator, input, options);
    }

    /// Retrieve details about an existing `Baseline` resource by specifying its
    /// identifier. For usage examples, see [ *the Amazon Web Services Control Tower
    /// User Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn getBaseline(self: *Self, allocator: std.mem.Allocator, input: get_baseline.GetBaselineInput, options: CallOptions) !get_baseline.GetBaselineOutput {
        return get_baseline.execute(self, allocator, input, options);
    }

    /// Returns the details of an asynchronous baseline operation, as initiated by
    /// any of these APIs: `EnableBaseline`, `DisableBaseline`,
    /// `UpdateEnabledBaseline`, `ResetEnabledBaseline`. A status message is
    /// displayed in case of operation failure. For usage examples, see [ *the
    /// Amazon Web Services Control Tower User Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn getBaselineOperation(self: *Self, allocator: std.mem.Allocator, input: get_baseline_operation.GetBaselineOperationInput, options: CallOptions) !get_baseline_operation.GetBaselineOperationOutput {
        return get_baseline_operation.execute(self, allocator, input, options);
    }

    /// Returns the status of a particular `EnableControl` or `DisableControl`
    /// operation. Displays a message in case of error. Details for an operation are
    /// available for 90 days. For usage examples, see the [ *Controls Reference
    /// Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn getControlOperation(self: *Self, allocator: std.mem.Allocator, input: get_control_operation.GetControlOperationInput, options: CallOptions) !get_control_operation.GetControlOperationOutput {
        return get_control_operation.execute(self, allocator, input, options);
    }

    /// Retrieve details of an `EnabledBaseline` resource by specifying its
    /// identifier.
    pub fn getEnabledBaseline(self: *Self, allocator: std.mem.Allocator, input: get_enabled_baseline.GetEnabledBaselineInput, options: CallOptions) !get_enabled_baseline.GetEnabledBaselineOutput {
        return get_enabled_baseline.execute(self, allocator, input, options);
    }

    /// Retrieves details about an enabled control. For usage examples, see the [
    /// *Controls Reference Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn getEnabledControl(self: *Self, allocator: std.mem.Allocator, input: get_enabled_control.GetEnabledControlInput, options: CallOptions) !get_enabled_control.GetEnabledControlOutput {
        return get_enabled_control.execute(self, allocator, input, options);
    }

    /// Returns details about the landing zone. Displays a message in case of error.
    pub fn getLandingZone(self: *Self, allocator: std.mem.Allocator, input: get_landing_zone.GetLandingZoneInput, options: CallOptions) !get_landing_zone.GetLandingZoneOutput {
        return get_landing_zone.execute(self, allocator, input, options);
    }

    /// Returns the status of the specified landing zone operation. Details for an
    /// operation are available for 90 days.
    pub fn getLandingZoneOperation(self: *Self, allocator: std.mem.Allocator, input: get_landing_zone_operation.GetLandingZoneOperationInput, options: CallOptions) !get_landing_zone_operation.GetLandingZoneOperationOutput {
        return get_landing_zone_operation.execute(self, allocator, input, options);
    }

    /// Returns a summary list of all available baselines. For usage examples, see [
    /// *the Amazon Web Services Control Tower User Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn listBaselines(self: *Self, allocator: std.mem.Allocator, input: list_baselines.ListBaselinesInput, options: CallOptions) !list_baselines.ListBaselinesOutput {
        return list_baselines.execute(self, allocator, input, options);
    }

    /// Provides a list of operations in progress or queued. For usage examples, see
    /// [ListControlOperation
    /// examples](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html#list-control-operations-api-examples).
    pub fn listControlOperations(self: *Self, allocator: std.mem.Allocator, input: list_control_operations.ListControlOperationsInput, options: CallOptions) !list_control_operations.ListControlOperationsOutput {
        return list_control_operations.execute(self, allocator, input, options);
    }

    /// Returns a list of summaries describing `EnabledBaseline` resources. You can
    /// filter the list by the corresponding `Baseline` or `Target` of the
    /// `EnabledBaseline` resources. For usage examples, see [ *the Amazon Web
    /// Services Control Tower User Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn listEnabledBaselines(self: *Self, allocator: std.mem.Allocator, input: list_enabled_baselines.ListEnabledBaselinesInput, options: CallOptions) !list_enabled_baselines.ListEnabledBaselinesOutput {
        return list_enabled_baselines.execute(self, allocator, input, options);
    }

    /// Lists the controls enabled by Amazon Web Services Control Tower on the
    /// specified organizational unit and the accounts it contains. For usage
    /// examples, see the [ *Controls Reference Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn listEnabledControls(self: *Self, allocator: std.mem.Allocator, input: list_enabled_controls.ListEnabledControlsInput, options: CallOptions) !list_enabled_controls.ListEnabledControlsOutput {
        return list_enabled_controls.execute(self, allocator, input, options);
    }

    /// Lists all landing zone operations from the past 90 days. Results are sorted
    /// by time, with the most recent operation first.
    pub fn listLandingZoneOperations(self: *Self, allocator: std.mem.Allocator, input: list_landing_zone_operations.ListLandingZoneOperationsInput, options: CallOptions) !list_landing_zone_operations.ListLandingZoneOperationsOutput {
        return list_landing_zone_operations.execute(self, allocator, input, options);
    }

    /// Returns the landing zone ARN for the landing zone deployed in your managed
    /// account. This API also creates an ARN for existing accounts that do not yet
    /// have a landing zone ARN.
    ///
    /// Returns one landing zone ARN.
    pub fn listLandingZones(self: *Self, allocator: std.mem.Allocator, input: list_landing_zones.ListLandingZonesInput, options: CallOptions) !list_landing_zones.ListLandingZonesOutput {
        return list_landing_zones.execute(self, allocator, input, options);
    }

    /// Returns a list of tags associated with the resource. For usage examples, see
    /// the [ *Controls Reference Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Re-enables an `EnabledBaseline` resource. For example, this API can re-apply
    /// the existing `Baseline` after a new member account is moved to the target
    /// OU. For usage examples, see [ *the Amazon Web Services Control Tower User
    /// Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn resetEnabledBaseline(self: *Self, allocator: std.mem.Allocator, input: reset_enabled_baseline.ResetEnabledBaselineInput, options: CallOptions) !reset_enabled_baseline.ResetEnabledBaselineOutput {
        return reset_enabled_baseline.execute(self, allocator, input, options);
    }

    /// Resets an enabled control. Does not work for controls implemented with SCPs.
    pub fn resetEnabledControl(self: *Self, allocator: std.mem.Allocator, input: reset_enabled_control.ResetEnabledControlInput, options: CallOptions) !reset_enabled_control.ResetEnabledControlOutput {
        return reset_enabled_control.execute(self, allocator, input, options);
    }

    /// This API call resets a landing zone. It starts an asynchronous operation
    /// that resets the landing zone to the parameters specified in the original
    /// configuration, which you specified in the manifest file. Nothing in the
    /// manifest file's original landing zone configuration is changed during the
    /// reset process, by default. This API is not the same as a rollback of a
    /// landing zone version, which is not a supported operation.
    pub fn resetLandingZone(self: *Self, allocator: std.mem.Allocator, input: reset_landing_zone.ResetLandingZoneInput, options: CallOptions) !reset_landing_zone.ResetLandingZoneOutput {
        return reset_landing_zone.execute(self, allocator, input, options);
    }

    /// Applies tags to a resource. For usage examples, see the [ *Controls
    /// Reference Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource. For usage examples, see the [ *Controls
    /// Reference Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an `EnabledBaseline` resource's applied parameters or version. For
    /// usage examples, see [ *the Amazon Web Services Control Tower User Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/userguide/baseline-api-examples.html).
    pub fn updateEnabledBaseline(self: *Self, allocator: std.mem.Allocator, input: update_enabled_baseline.UpdateEnabledBaselineInput, options: CallOptions) !update_enabled_baseline.UpdateEnabledBaselineOutput {
        return update_enabled_baseline.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an already enabled control.
    ///
    /// If the enabled control shows an `EnablementStatus` of SUCCEEDED, supply
    /// parameters that are different from the currently configured parameters.
    /// Otherwise, Amazon Web Services Control Tower will not accept the request.
    ///
    /// If the enabled control shows an `EnablementStatus` of FAILED, Amazon Web
    /// Services Control Tower updates the control to match any valid parameters
    /// that you supply.
    ///
    /// If the `DriftSummary` status for the control shows as `DRIFTED`, you cannot
    /// call this API. Instead, you can update the control by calling the
    /// `ResetEnabledControl` API. Alternatively, you can call `DisableControl` and
    /// then call `EnableControl` again. Also, you can run an extending governance
    /// operation to repair drift. For usage examples, see the [ *Controls Reference
    /// Guide*
    /// ](https://docs.aws.amazon.com/controltower/latest/controlreference/control-api-examples-short.html).
    pub fn updateEnabledControl(self: *Self, allocator: std.mem.Allocator, input: update_enabled_control.UpdateEnabledControlInput, options: CallOptions) !update_enabled_control.UpdateEnabledControlOutput {
        return update_enabled_control.execute(self, allocator, input, options);
    }

    /// This API call updates the landing zone. It starts an asynchronous operation
    /// that updates the landing zone based on the new landing zone version, or on
    /// the changed parameters specified in the updated manifest file.
    pub fn updateLandingZone(self: *Self, allocator: std.mem.Allocator, input: update_landing_zone.UpdateLandingZoneInput, options: CallOptions) !update_landing_zone.UpdateLandingZoneOutput {
        return update_landing_zone.execute(self, allocator, input, options);
    }

    pub fn listBaselinesPaginator(self: *Self, params: list_baselines.ListBaselinesInput) paginator.ListBaselinesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listControlOperationsPaginator(self: *Self, params: list_control_operations.ListControlOperationsInput) paginator.ListControlOperationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnabledBaselinesPaginator(self: *Self, params: list_enabled_baselines.ListEnabledBaselinesInput) paginator.ListEnabledBaselinesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEnabledControlsPaginator(self: *Self, params: list_enabled_controls.ListEnabledControlsInput) paginator.ListEnabledControlsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLandingZoneOperationsPaginator(self: *Self, params: list_landing_zone_operations.ListLandingZoneOperationsInput) paginator.ListLandingZoneOperationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLandingZonesPaginator(self: *Self, params: list_landing_zones.ListLandingZonesInput) paginator.ListLandingZonesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
