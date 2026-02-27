const BillingMethod = @import("billing_method.zig").BillingMethod;
const Device = @import("device.zig").Device;
const DeviceMinutes = @import("device_minutes.zig").DeviceMinutes;
const DeviceProxy = @import("device_proxy.zig").DeviceProxy;
const RemoteAccessEndpoints = @import("remote_access_endpoints.zig").RemoteAccessEndpoints;
const InteractionMode = @import("interaction_mode.zig").InteractionMode;
const ExecutionResult = @import("execution_result.zig").ExecutionResult;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Represents information about the remote access session.
pub const RemoteAccessSession = struct {
    /// The ARN for the app to be installed onto your device.
    app_upload: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the remote access session.
    arn: ?[]const u8,

    /// The billing method of the remote access session. Possible values include
    /// `METERED` or
    /// `UNMETERED`. For more information about metered devices, see [AWS Device
    /// Farm
    /// terminology](https://docs.aws.amazon.com/devicefarm/latest/developerguide/welcome.html#welcome-terminology).
    billing_method: ?BillingMethod,

    /// The date and time the remote access session was created.
    created: ?i64,

    /// The device (phone or tablet) used in the remote access session.
    device: ?Device,

    /// The number of minutes a device is used in a remote access session (including
    /// setup
    /// and teardown minutes).
    device_minutes: ?DeviceMinutes,

    /// The device proxy configured for the remote access session.
    device_proxy: ?DeviceProxy,

    /// Unique device identifier for the remote device. Only returned if remote
    /// debugging
    /// is enabled for the remote access session.
    ///
    /// Remote debugging is [no
    /// longer
    /// supported](https://docs.aws.amazon.com/devicefarm/latest/developerguide/history.html).
    device_udid: ?[]const u8,

    /// The endpoint for the remote access session. This field is deprecated, and is
    /// replaced by the new `endpoints.interactiveEndpoint` field.
    endpoint: ?[]const u8,

    endpoints: ?RemoteAccessEndpoints,

    /// The ARN of the instance.
    instance_arn: ?[]const u8,

    /// The interaction mode of the remote access session. Changing the interactive
    /// mode of remote access sessions is no longer available.
    interaction_mode: ?InteractionMode,

    /// A message about the remote access session.
    message: ?[]const u8,

    /// The name of the remote access session.
    name: ?[]const u8,

    /// The result of the remote access session. Can be any of the following:
    ///
    /// * PENDING.
    ///
    /// * PASSED.
    ///
    /// * WARNED.
    ///
    /// * FAILED.
    ///
    /// * SKIPPED.
    ///
    /// * ERRORED.
    ///
    /// * STOPPED.
    result: ?ExecutionResult,

    /// When set to `true`, for private devices, Device Farm does not sign your app
    /// again. For public
    /// devices, Device Farm always signs your apps again.
    ///
    /// For more information about how Device Farm re-signs your apps, see [Do you
    /// modify my app?](http://aws.amazon.com/device-farm/faqs/) in the *AWS Device
    /// Farm FAQs*.
    skip_app_resign: ?bool,

    /// The date and time the remote access session was started.
    started: ?i64,

    /// The status of the remote access session. Can be any of the following:
    ///
    /// * PENDING.
    ///
    /// * PENDING_CONCURRENCY.
    ///
    /// * PENDING_DEVICE.
    ///
    /// * PROCESSING.
    ///
    /// * SCHEDULING.
    ///
    /// * PREPARING.
    ///
    /// * RUNNING.
    ///
    /// * COMPLETED.
    ///
    /// * STOPPING.
    status: ?ExecutionStatus,

    /// The date and time the remote access session was stopped.
    stopped: ?i64,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .app_upload = "appUpload",
        .arn = "arn",
        .billing_method = "billingMethod",
        .created = "created",
        .device = "device",
        .device_minutes = "deviceMinutes",
        .device_proxy = "deviceProxy",
        .device_udid = "deviceUdid",
        .endpoint = "endpoint",
        .endpoints = "endpoints",
        .instance_arn = "instanceArn",
        .interaction_mode = "interactionMode",
        .message = "message",
        .name = "name",
        .result = "result",
        .skip_app_resign = "skipAppResign",
        .started = "started",
        .status = "status",
        .stopped = "stopped",
        .vpc_config = "vpcConfig",
    };
};
